Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264392AbTICUJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264432AbTICUIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:08:42 -0400
Received: from codepoet.org ([166.70.99.138]:30123 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id S264392AbTICUGv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:06:51 -0400
Date: Wed, 3 Sep 2003 14:06:50 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: steveb@unix.lancs.ac.uk, linux-kernel@vger.kernel.org
Subject: Re: corruption with A7A266+200GB disk?
Message-ID: <20030903200650.GB14475@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	steveb@unix.lancs.ac.uk, linux-kernel@vger.kernel.org
References: <20030903013741.GA1601@codepoet.org> <Pine.LNX.4.44.0309031653290.6102-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309031653290.6102-100000@logos.cnet>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Sep 03, 2003 at 04:54:28PM -0300, Marcelo Tosatti wrote:
> > > I reduced the size of /home to 40GB and everything was fine.
> > > I see the same behaviour with both 2.6.0test3 and 2.4.22.
> > 
> > Known problem.  For some reason Marcelo has not yet applied 
> > the fix for this problem to the 2.4.x kernels...
> 
> So it seems the fix is already in 2.4.23-pre2 (came in through Alan IDE
> changes). 
> 
> Steve, it seems 2.4.23-pre2 fixes your problem. 

Marcelo, I think you are mistaken...  You have indeed applied
some IDE fixes from Alan.  But I just read all the IDE changes
again, and unless I have gone blind, this problem is not yet
fixed.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
