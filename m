Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVKMRjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVKMRjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 12:39:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbVKMRjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 12:39:31 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:44448 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751354AbVKMRjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 12:39:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=3tbm57aYvSMiwF0Pd4NCNVkufWmzFMANdzgKOu3aeWSt5dRrqqHT0iNmUr6+c6u6IkYYR0CPzjlKucQyRSsDkdMgwNapRVAobPjNi0ESqhdwt+95SIvROZ4+JusGBtsm46dXRlLOC+kboS1aU3M/OAfCp0NddFXBzCOP88vFRvE=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: Junichi Uekawa <dancer@netfort.gr.jp>
Subject: Re: [uml-user] 2.6.14.git: user-mode-linux/x86_64 does not build
Date: Sun, 13 Nov 2005 18:46:53 +0100
User-Agent: KMail/1.8.3
Cc: user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <87r79mfxjj.dancerj%dancer@netfort.gr.jp> <200511121304.12747.blaisorblade@yahoo.it> <87u0ehyx2b.dancerj%dancer@netfort.gr.jp>
In-Reply-To: <87u0ehyx2b.dancerj%dancer@netfort.gr.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511131846.53764.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 November 2005 05:46, Junichi Uekawa wrote:
> Hi
>
> > > UML does not build from linus's git tree for a while, with the
> > > following compilation error.

> A snippet of a log of a functional UML session:
> sh-3.00# chroot /home/dancer/i386-chroot/1/ /bin/bash
> chroot: cannot run command `/bin/bash': Exec format error
> sh-3.00# file /home/dancer/i386-chroot/1/bin/bash
> /home/dancer/i386-chroot/1/bin/bash: ELF 32-bit LSB executable, Intel
> 80386, version 1 (SYSV), for GNU/Linux 2.2.0, dynamically linked (uses
> shared libs), stripped sh-3.00# uname -a
> Linux (none) 2.6.14-g508862e4 #1 Sun Nov 13 13:30:32 JST 2005 x86_64
> GNU/Linux

Yes, it is known - the implementation of 32-bit support is still a TODO item. 
Luckily, there are 32-bit UMLs for that, in fact the request is still low. 
We'll do it, however.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
