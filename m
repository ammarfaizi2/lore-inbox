Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932377AbVI2TW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932377AbVI2TW1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVI2TWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:22:24 -0400
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96]:50291 "HELO
	smtp007.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932375AbVI2TWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:22:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:User-Agent:Cc:MIME-Version:Content-Disposition:Date:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=wAkL67rM4/37wjHzX9yB5T03VLojOeoEx2bVK5eUQ6kGS1T8RGhY7CZSAm/p9hUc+6OSBXj0akGOoFxQhsQUZB5a3je6Jmik42x2USzk7kok3W/2GevHuao2kyBfffJ3O3pFsNPGHcZyotO/kAzVUoV2F2vxr+NqKntc9NAeFX0=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/5] Other important UML fixes for 2.6.14
User-Agent: KMail/1.8.2
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net,
       LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Date: Thu, 29 Sep 2005 21:02:43 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509292102.44942.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is what I've currently in my tree for 2.6.14. It's not enough to fix all 
regressions (there are still some problems on which Jeff is working right 
now, namely UBD and x86-64 without frame pointers).

This includes the critical fixes for my UML fault handler breakage - this time 
I ran a kernel compile under each UML running mode (last time I couldn't test 
SKAS3) with these patches.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
