Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293482AbSCCGr4>; Sun, 3 Mar 2002 01:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293521AbSCCGrr>; Sun, 3 Mar 2002 01:47:47 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:40920 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S293482AbSCCGrh>; Sun, 3 Mar 2002 01:47:37 -0500
Message-ID: <3C81C6C7.8030902@linuxhq.com>
Date: Sun, 03 Mar 2002 01:46:31 -0500
From: John Weber <john.weber@linuxhq.com>
Organization: Linux Headquarters
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020206
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Stelian Pop <stelian.pop@fr.alcove.com>
Subject: Re: Linux 2.5.6-pre2 and ALSA Sound
In-Reply-To: <fa.cgp5alv.114qq93@ifi.uio.no> <fa.hjuh5ov.l223o4@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> On Fri, Mar 01, 2002 at 02:47:39AM -0500, John Weber wrote:
> 
> 
>>Anyone else having trouble with ALSA YMFPCI?  Everything compiles, but I 
>>can't hear a thing (even with OSS compatibility enabled).
>>
> 
> It does work for me at least, on a VAIO C1VE, kernel 2.5.6-pre2.
> 
> lspci:
> 	00:09.0 Multimedia audio controller: Yamaha Corporation YMF-754 [DS-1E Audio Controller]
> 
> .config:
> 	CONFIG_SND=m
> 	CONFIG_SND_SEQUENCER=m
> 	CONFIG_SND_OSSEMUL=y
> 	CONFIG_SND_MIXER_OSS=m
> 	CONFIG_SND_PCM_OSS=m
> 	CONFIG_SND_SEQUENCER_OSS=m
> 
> Stelian.
> 

It does not work for me.  It appears to be working (the apps look like 
they are playing an MP3, but no sound).

.config
CONFIG_SND=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_YMFPCI=y

lspci:
Multimedia audio controller: Yamaha Corporation YMF-744B [DS-1S Audio 
Controller] (rev 02)

(And I know that the default mixer settings are mute... blah,blah).

Any suggestions?


-- 
(o- j o h n   e   w e b e r
//\  http://www.linuxhq.com/people/weber/
v_/_ john.weber@linuxhq.com

