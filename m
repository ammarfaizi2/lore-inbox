Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271911AbRJXORV>; Wed, 24 Oct 2001 10:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273588AbRJXORL>; Wed, 24 Oct 2001 10:17:11 -0400
Received: from mailgate.FH-Aachen.DE ([149.201.10.254]:22964 "EHLO
	mailgate.fh-aachen.de") by vger.kernel.org with ESMTP
	id <S271911AbRJXORG>; Wed, 24 Oct 2001 10:17:06 -0400
Posted-Date: Wed, 24 Oct 2001 16:10:13 +0100 (WEST)
Date: Wed, 24 Oct 2001 16:23:45 +0200
From: f5ibh <f5ibh@db0bm.ampr.org>
Message-Id: <200110241423.QAA03509@db0bm.ampr.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac, lm-sensors broken ??
Cc: safemode@speakeasy.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
>I use it quite nicely on 2.4.12-ac3   the latest i2c stack is already in the
>ac branch, you need not compile it on your own.  lm sensors version 2.6.1 and
>up is supported.  Just compile and install it.  (make;make install).

So I've done : get rid of the external i2c package, compiled the built-in i2c
stack. make and make install for the lm_sensors (2.6.1)...
... It does not work

in /proc/sys/dev/sensors/ I've only one empty file called chips

with 2.4.13, I've the following :

[root@debian-f5ibh] ~ # ls /proc/sys/dev/sensors/
chips
w83781d-isa-0290/

[root@debian-f5ibh] ~ # cat /proc/sys/dev/sensors/chips
256     w83781d-isa-0290

[root@debian-f5ibh] ~ # ls /proc/sys/dev/sensors/w83781d-isa-0290/
alarms  beep  fan1  fan2  fan3  fan_div  in0  in1  in2  in3  in4  in5  in6  rt1
rt2  rt3  temp1  temp2  temp3  vid

----------
Regards
		Jean-Luc
