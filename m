Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316853AbSEVEoc>; Wed, 22 May 2002 00:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316854AbSEVEob>; Wed, 22 May 2002 00:44:31 -0400
Received: from [212.42.230.145] ([212.42.230.145]:62681 "EHLO
	pomo.hostsharing.net") by vger.kernel.org with ESMTP
	id <S316853AbSEVEob>; Wed, 22 May 2002 00:44:31 -0400
Date: Wed, 22 May 2002 06:44:29 +0200
From: Michael Hoennig <michael@hostsharing.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: suid bit on directories
Message-Id: <20020522064429.0f8c7ea7.michael@hostsharing.net>
In-Reply-To: <Pine.LNX.3.96.1020521135800.1427B-100000@gatekeeper.tmr.com>
Organization: http://www.hostsharing.net
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> > Anyway, when I find time in the next weeks, I will try this patch and
> > post it.  I will do it as a mount option.  Nobody is forced to use it
> > ;-)
> 
> If I might offer a suggestion, that requires a patched mount command,
> etc. I would offer as an alternative implementation which might be both
> easier to do and more useful in testing. Make the capability an option
> in the kernel, and then require that it be enabled in /proc/sys with
> default off. Think TCP_SYN_COOKIES or similar. That way you can have a
> single patch set for the kernel only, and no one can possibly "stumble
> on it" and complain. Also, you can disable without reboot or remount
> after testing.

Good idea; I will consider it.  

	Michael

-- 
Hostsharing eG / c/o Michael Hönnig / Boytinstr. 10 / D-22143 Hamburg
phone:+49/40/67581419 / mobile:+49/177/3787491 / fax:++49/40/67581426
http://www.hostsharing.net ---> Webhosting Spielregeln selbst gemacht
