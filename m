Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVDVAXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVDVAXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261839AbVDVAVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:21:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:11404 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261807AbVDVAUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:20:54 -0400
Date: Fri, 22 Apr 2005 02:20:43 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tony.luck@intel.com, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull
Message-ID: <20050422002043.GC1474@pasky.ji.cz>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com> <Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org> <200504212155.j3LLtho04949@unix-os.sc.intel.com> <200504212155.j3LLtho04949@unix-os.sc.intel.com> <200504212301.j3LN1Do05507@unix-os.sc.intel.com> <Pine.LNX.4.58.0504211608300.2344@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504211608300.2344@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 01:19:47AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> So in the long run this issue goes away - we'll just have synchronization 
> tools that won't get any unnecessary pollution. But in the short run I 
> actually check my git archive religiously for being clean, and I do
> 
> 	fsck-cache --unreachable $(cat .git/HEAD)
> 
> quite often - not because git has been flaky, but simply beause I'm anal. 
> And getting objects from other branches would mess with that..

(Note that when using git-pasky, you need to do

	fsck-cache --unreachable $(cat .git/heads/*)

instead.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
