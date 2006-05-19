Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWESURs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWESURs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 16:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbWESURs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 16:17:48 -0400
Received: from ns2.suse.de ([195.135.220.15]:11420 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964813AbWESURs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 16:17:48 -0400
From: Andi Kleen <ak@suse.de>
To: Daniel Jacobowitz <dan@debian.org>
Subject: Re: [PATCH] 2-ptrace_multi
Date: Fri, 19 May 2006 22:17:30 +0200
User-Agent: KMail/1.9.1
Cc: Renzo Davoli <renzo@cs.unibo.it>, Ulrich Drepper <drepper@gmail.com>,
       osd@cs.unibo.it, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
References: <20060518155337.GA17498@cs.unibo.it> <20060519174534.GA22346@cs.unibo.it> <20060519201509.GA13477@nevyn.them.org>
In-Reply-To: <20060519201509.GA13477@nevyn.them.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605192217.30518.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 May 2006 22:15, Daniel Jacobowitz wrote:

> On Fri, May 19, 2006 at 07:45:34PM +0200, Renzo Davoli wrote:
> > #ifndef mem_write
> > /* This is a security hazard */
> 
> I believe the conclusion, when this was last discussed, was that this
> is not true and could be fixed.

iirc the main problem was mmap of /proc/*/mem. write can be probably 
enabled after some auditing.

Alan hacked on this iirc so he might comment.

-Andi
