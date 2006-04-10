Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750939AbWDJP7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWDJP7A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 11:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWDJP7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 11:59:00 -0400
Received: from nproxy.gmail.com ([64.233.182.187]:57385 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750939AbWDJP67 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 11:58:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=FHl3L4xoFamc3QSo5rduiNND3SOudVo1yww2W3a+r91jqM190lZdvQ5hWhzr9lJWabT0DrVG1JBjE+IEf6stBTPHpriDvHj/4pazW0Uy/NsxsjcceKmxfmpN+FyGMGwFFOyIjCBRSBw/LXE0wCIzUbfh0waWUjVVKS2KIwJ2Gs8=
Message-ID: <443A8093.80505@gmail.com>
Date: Mon, 10 Apr 2006 17:57:48 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Shlomi Fish <shlomif@iglu.org.il>
CC: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: Two OOPSes in ALSA with kernel-2.6.17-rc1
References: <200604101823.54600.shlomif@iglu.org.il>
In-Reply-To: <200604101823.54600.shlomif@iglu.org.il>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Shlomi Fish napsal(a):
> Hi all!
> 
> (Please CC me on the replies)
> 
> I recently received these two OOPSes with kernel-2.6.17-rc1. They happened 
> while mpg123 was playing a WAV file and I invoked KDE (along with artsd).
> 
> My soundcard is snd_intel8x0.
> 
> Let me know if you need any other information.
Try to turn sound debug on and retest.
It seems like struct snd_pcm_runtime *runtime is NULL.

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEOoCTMsxVwznUen4RAkbcAJ4lYUt9LK5t9ECKbcy453qYPlOahACfR5pz
zWEa8B9DzvmbKsdwyTVe49c=
=YvAt
-----END PGP SIGNATURE-----
