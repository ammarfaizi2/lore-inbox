Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423441AbWJZGIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423441AbWJZGIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 02:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423442AbWJZGIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 02:08:42 -0400
Received: from smtp010.mail.ukl.yahoo.com ([217.12.11.79]:55210 "HELO
	smtp010.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1423441AbWJZGIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 02:08:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=dtGmVtGu7XlGLkMeNABx5Dh7GG6Alf1VqtZ+TsS3iPgwPAW3tuw7ndI98qePQtYCT12CbGUPEVTVQP+uzMQ6kXKUFx2WnnAe3VInNhM1cySzqyHxzeT5ev9mna7M2J2wnMMiVMpANgZbMMAR+FhtzPXacGyPYAjcAvZk59Nsv78=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 01/14] uml: fix compilation options for USER_OBJS
Date: Thu, 26 Oct 2006 08:08:26 +0200
User-Agent: KMail/1.9.5
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <20061009163208.GA4931@ccure.user-mode-linux.org> <20061011110828.43576.qmail@web25221.mail.ukl.yahoo.com> <20061013201010.GC5517@ccure.user-mode-linux.org>
In-Reply-To: <20061013201010.GC5517@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610260808.27508.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 22:10, Jeff Dike wrote:
> On Wed, Oct 11, 2006 at 01:08:27PM +0200, Paolo Giarrusso wrote:
> > Ok, at a first glance this alternative solution is ok. Make sure (run
> > gdb on an userspace object file and saying list <function>) that it
> > works and we'll be ok.
>
> After discovering that the original patch broke UML/i386 and broke the
> UML/x86_64 build, I now have the patch below.
Where is it? It should go in 2.6.19. I'm going to test it locally and merge 
it.
> Listing userspace functions is fine.
Good...
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
