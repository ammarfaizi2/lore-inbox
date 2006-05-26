Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWEZL5g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWEZL5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 07:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbWEZL5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 07:57:11 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:45463 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932475AbWEZL47 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 07:56:59 -0400
Date: Fri, 26 May 2006 13:56:02 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linus Torvalds <torvalds@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems
 to like Lordi...)
In-Reply-To: <20060525202917.GB21926@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.61.0605261354220.899@yvahk01.tjqt.qr>
References: <20060525141714.GA31604@skunkworks.cabal.ca>
 <Pine.LNX.4.61.0605252027380.13379@yvahk01.tjqt.qr>
 <Pine.LNX.4.64.0605251146260.5623@g5.osdl.org> <200605251954.06227.s0348365@sms.ed.ac.uk>
 <20060525202917.GB21926@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>rceng02:~# hostname
>rceng02
>rceng02:~# hostname -f
>rceng02.eng.lan
>rceng02:~# head -1 /etc/hosts
>127.0.0.1       rceng02.eng.lan localhost.localdomain   localhost
>rceng02
>rceng02:~#
>
>I always thought that was how it worked.  The first hostname in
>/etc/hosts on the line containing the short name was used as the FQDN.
>Maybe that is only a gnu hostname thing.  I seem to recall solaris had a
>domainname file that was used to find the domain part of the FQDN
>instead.
>
What a mess. I would prefer to see Linux distributions have
127.0.0.1 localhost
in their /etc/hosts (to have the standard 127.0.0.1<->localhost mapping) 
and /etc/HOSTNAME contain the hostname, which is 
sethostname()d/setdomainname()d by init scripts and gethostname()d by apps.


Jan Engelhardt
-- 
