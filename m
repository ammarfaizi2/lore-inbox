Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261404AbTDDXD6 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbTDDXD6 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:03:58 -0500
Received: from h008.c015.snv.cp.net ([209.228.35.123]:9640 "HELO
	c015.snv.cp.net") by vger.kernel.org with SMTP id S261404AbTDDXD5 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 18:03:57 -0500
X-Sent: 4 Apr 2003 23:15:25 GMT
Message-ID: <3E8E1243.70208@lemur.sytes.net>
Date: Fri, 04 Apr 2003 18:16:19 -0500
From: Mathias Kretschmer <mathias@lemur.sytes.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre7: compilation error in ac97_codec.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
-nostdinc -iwithprefix include -DKBUILD_BASENAME=ac97_codec 
-DEXPORT_SYMTAB -c ac97_codec.c
ac97_codec.c:131: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
ac97_codec.c:131: initializer element is not constant
ac97_codec.c:131: (near initialization for `ac97_codec_ids[12].flags')
ac97_codec.c:132: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
ac97_codec.c:132: initializer element is not constant
ac97_codec.c:132: (near initialization for `ac97_codec_ids[13].flags')
ac97_codec.c:133: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
ac97_codec.c:133: initializer element is not constant
ac97_codec.c:133: (near initialization for `ac97_codec_ids[14].flags')
ac97_codec.c:144: `AC97_DELUDED_MODEM' undeclared here (not in a function)
ac97_codec.c:144: initializer element is not constant
ac97_codec.c:144: (near initialization for `ac97_codec_ids[25].flags')
ac97_codec.c: In function `ac97_probe_codec':
ac97_codec.c:763: structure has no member named `modem'
ac97_codec.c:774: structure has no member named `flags'
ac97_codec.c:780: structure has no member named `flags'
ac97_codec.c:780: `AC97_DELUDED_MODEM' undeclared (first use in this 
function)
ac97_codec.c:780: (Each undeclared identifier is reported only once
ac97_codec.c:780: for each function it appears in.)
ac97_codec.c:781: structure has no member named `modem'
ac97_codec.c:786: structure has no member named `modem'
ac97_codec.c: In function `ac97_init_mixer':
ac97_codec.c:808: structure has no member named `flags'
ac97_codec.c:808: `AC97_NO_PCM_VOLUME' undeclared (first use in this 
function)
ac97_codec.c:839: structure has no member named `flags'
make[3]: *** [ac97_codec.o] Error 1
make[3]: Leaving directory `/usr/src/linux-2.4.20/drivers/sound'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/usr/src/linux-2.4.20/drivers/sound'
make[1]: *** [_subdir_sound] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.20/drivers'
make: *** [_dir_drivers] Error 2

