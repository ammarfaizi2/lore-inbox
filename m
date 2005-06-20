Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVFTU3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVFTU3I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 16:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFTU2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 16:28:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33153 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261563AbVFTU1A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 16:27:00 -0400
Date: Mon, 20 Jun 2005 13:24:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: masbock@us.ibm.com, linux-kernel@vger.kernel.org, vernux@us.ibm.com
Subject: Re: 2.6.12-mm1: drivers/misc/ibmasm/ compile error
Message-Id: <20050620132438.41f613a5.akpm@osdl.org>
In-Reply-To: <20050620173831.GB3666@stusta.de>
References: <20050619233029.45dd66b8.akpm@osdl.org>
	<20050620173831.GB3666@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> > +ibmasm-driver-redesign-handling-of-remote-control.patch
> >...
> >  IBMASM driver updates
> >...
> 
> "debug" is a bad name for a global variable:

Sure is.  I renamed it to ibmasm_debug.
