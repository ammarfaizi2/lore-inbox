Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262285AbVBBSEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262285AbVBBSEK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 13:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262363AbVBBSEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 13:04:10 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:51205 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S262297AbVBBSCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 13:02:14 -0500
Date: Wed, 2 Feb 2005 19:02:01 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Sabotaged PaXtest (was: Re: Patch 4/6  randomize the stack pointer)
Message-ID: <20050202180201.GD32560@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200501311015.20964.arjan@infradead.org> <420151B3.27974.D9F79C@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420151B3.27974.D9F79C@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02, 2005 at 10:18:27PM +1000, pageexec@freemail.hu wrote:
> your concerns would be valid if this was impossible to achieve by an
> exploit, sadly, you'd be wrong too, it's possible to force an exploited
> application to call something like dl_make_stack_executable() and then
> execute the shellcode.

If you can call mprotect() with a protected environment to unprotect
it, you can as easily call exec.

  OG.
