Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265490AbUHMXK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265490AbUHMXK1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 19:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267654AbUHMXK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 19:10:27 -0400
Received: from the-village.bc.nu ([81.2.110.252]:52698 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265490AbUHMXKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 19:10:22 -0400
Subject: Re: 2.6.x Fork Problem?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: Jesse Pollard <jesse@cats-chateau.net>, Torin Ford <code-monkey@qwest.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040813190958.GB18563@janus>
References: <006101c47fff$8feedac0$0200000a@torin>
	 <04081209262700.19998@tabby>  <20040813190958.GB18563@janus>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092434870.25002.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 23:07:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-08-13 at 20:09, Frank van Maarseveen wrote:
> > Yup - the parent process executed waitpid before the child process finished 
> > the setup. This can happen in a multi-cpu environment or even a single, if
> > the scheduler puts the parent process higher than the child in the queue.
> 
> ugh! I can follow the rationale for SMP.

Such a behaviour would not be rational, so we don't do anything like
that.

