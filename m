Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWDJRQr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWDJRQr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 13:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbWDJRQr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 13:16:47 -0400
Received: from nproxy.gmail.com ([64.233.182.185]:8463 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751223AbWDJRQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 13:16:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=tcEiKpZnIavOnIfEa89uhwCBUETJRk4zkKHjlYIzWxwWshgsAlQ9aMghNx5fbhAFsiK5eghPUCzJYpFrWaNZTXi+8UWB0Fcet3+JJPZDD9WDJ72vGIK/V3h0rQocfGMUWp9J7LFo8zj50D4OPQCoWJY5rx+nhgoMXZN0sgeOCsc=
Message-ID: <443A92F8.6020704@gmail.com>
Date: Mon, 10 Apr 2006 19:16:17 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Shlomi Fish <shlomif@iglu.org.il>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, perex@suse.cz
Subject: Re: [Alsa-devel] Re: Two OOPSes in ALSA with kernel-2.6.17-rc1
References: <200604101823.54600.shlomif@iglu.org.il>	<443A8093.80505@gmail.com> <s5hd5fp4aqv.wl%tiwai@suse.de>
In-Reply-To: <s5hd5fp4aqv.wl%tiwai@suse.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Takashi Iwai napsal(a):
> At Mon, 10 Apr 2006 17:57:48 +0159,
> Jiri Slaby wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Shlomi Fish napsal(a):
>>> Hi all!
>>>
>>> (Please CC me on the replies)
>>>
>>> I recently received these two OOPSes with kernel-2.6.17-rc1. They happened 
>>> while mpg123 was playing a WAV file and I invoked KDE (along with artsd).
>>>
>>> My soundcard is snd_intel8x0.
>>>
>>> Let me know if you need any other information.
>> Try to turn sound debug on and retest.
>> It seems like struct snd_pcm_runtime *runtime is NULL.
> 
> In which function?
Sorry, I cut it away:
http://lkml.org/lkml/2006/4/10/130

regards,
- --
Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFEOpL4MsxVwznUen4RAhZGAJoC1vnWGKCuRy5AETmc/37i6rMhOwCfYVrr
PxufLfOVmdORm2vb91dRiKw=
=LYPV
-----END PGP SIGNATURE-----
