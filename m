Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263873AbTJEWTM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 18:19:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263921AbTJEWTM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 18:19:12 -0400
Received: from imap.gmx.net ([213.165.64.20]:55256 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263873AbTJEWTF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 18:19:05 -0400
X-Authenticated: #1620105
From: Andreas Hemel <dai.shan@gmx.net>
To: Dan <overridex@punkass.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test6 Quake3/Wolfenstein Lockups
Date: Mon, 6 Oct 2003 00:19:06 +0200
User-Agent: KMail/1.5.2
References: <1065002791.5548.5.camel@nazgul.overridex.net>
In-Reply-To: <1065002791.5548.5.camel@nazgul.overridex.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_ajJg/WQfVNa7D5m"
Message-Id: <200310060019.06597.dai.shan@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_ajJg/WQfVNa7D5m
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 01 October 2003 12:06, Dan wrote:
> Hi there,
>
> I'm experiencing frequent hard lockups (magic sysrq doesn't even
> work) when exiting quake3 or return to castle wolfenstein on
> 2.6.0-test5 and test6... they happen about 50% of the time, and
> usually my quake3 config file is missing when I boot back up.  They
> only happen after clicking to bypass the credits screens when exiting
> the games... is anyone experiencing this?  I'm unable to strace
> quake3 as it won't start up at all when straced, and I can't get
> return to castle wolfenstein to lockup when it's straced.  I'm
> running a dual athlon 1700 machine, with reiserfs and LVM.  This
> lockup doesn't happen on 2.4.x nor did it happen on 2.5.72 (though at
> the time I was running raid-0 and not lvm) If anyone else is having
> this problem I'd like to hear it, or if anyone else wants info just
> let me know.  Please cc me any replies. -Dan
>

I have got similar problems with quake3 and rtcw und 2.6.0-test6, I'm 
able to start quake3 once and exit with out any problems, but starting 
it a second time it just hangs with a black screen. I'm able to switch 
to console and kill it (it's using 100% cpu, but ~45% is actually used 
by the kernel), but my mouse won't move until I restart X.
But I think the new nvidia driver (4496) causes this, since I see 
exactly the same behavior under 2.4.22. Also the graphics in quake3 are 
are very weird and ut2003 and tenebrae (a modified quake1) won't even 
start. (complaining about missing OpenGL functions as far as I can 
tell)

If anyone is interested anyway, I atached the strace of the first and 
second quake3 run.

--Boundary-00=_ajJg/WQfVNa7D5m
Content-Type: application/x-gzip;
  name="q3first.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="q3first.txt.gz"

H4sICK2OgD8AA3EzZmlyc3QudHh0AN1YaW/aSBj+nl8xS1cVVBB7xicroS4Fk1ol0AVn0ypEyNhD
sGJsapuUbNP97Tszdog5Ajah3dWCED5mnvd43svGC2zd4WKBm4cB5/qW6XIjx+O+zM1bLBTK4KqQ
HF6TY+4NEBC4M4MQvOGuS6AG+JO5Z05x8Vt4H9YKbcebL8gmz7dxrXDrV0amS05PT0+/x4tHwW2R
L4G9H7J2ofK2yfP8ie/aw+nUnBU7F+12GYh8VS6Dj72uMexp9eYDO7rs6YZWBuf1j8OPPf3PuqE9
0ON6p9v5fN696JdBBZYBz5RYiDwPBYY8wx6xHEcW59qnoX86C7DrmzZRuTvsNbud9udSrE0FAq3T
1ToGKHZ8EM6tCRg7LgZ+AGwnwFbkB/elTTzLtCZ4HY3iCSfjMDIjWSwKZfAtjIZT6rH+UG/1tLMH
XhbFMiBXQ+cvXJN5CfFpJ645JLm/9MiKG8pAWLFbpHZbrh/iorCXByYstsl1RvTnWfMgxCG1TVq1
i9oUYNOmBhUGUFG0dmsA2Zff+ArJL7kXDQQRDfgCMbEMJIiouuQvh4+QoMIq2uEkJAoyUjfiRvuk
NXb5CwkrEciuSTK5RtYhRd4EfCYQW/onrRljLwRE9i8lMLR1CZhJgFVZzCVgd8wz1Bdwb7uUdrQZ
zi/ifgDJ6cvIVxVR3UE9hLLK52ZeGm/yIkPGS54KlCYepnlnWC9gw6JkyFvIeBkbCInXA5iPDEWS
nsiAUEQEZCcfEmSM5WRERhuMEBzGCOLFLRRnoQSmSYnh1kVUmQj1qMkYo+aj//htECoW1WI695Yh
DmOHsp6yrhbVIqA038wC35qa4W2xr58N37W7jQ9lEKt11TPO9Q6ZFdRSOmhtfMdF0X0Srpe9h+6Q
6MR2ksN2vXemtfS2VmLBm8crhwwUB++hZyMWL/v2jA6QM1qRY2WSw/i7wdHcsQVU3COrBmCy/Cbf
cpwFPrU8C3yyPG88RQ4ZNumtDMrLkqBWFQHmJcJaIcLORIR9AOH2ihycSQ5em1unkTna1gSSPXnm
TIHfNWVCAfIKennFYUYv2xMrDBPbVAAHAuyEOBiHIPgKeMAPPBoVcSeKhbPqkLNqpmpbLPsJbGNt
4lYqlpviqeON/a2u3etWMe3WXU49ThFfdek5nhp+ZLq/JdoqiiTLIrh9N/DIrVaAE5fySGTdXUEv
dSi1YmPvAcUZr+TDOFM+jJ+KiGlFju/REtJ43yYN/hstJs1W+/vKYVJHjrBF7xg/fMcfF/oP25K9
6O4QoZ91torI9VYgyaUCN/GnmLNNJ5yYXmEts5p6b23UFFUJbYM5zb+VdK2ZY+/riKytqJIYr8+y
ga0XqnkzYZzOBJoW+zOBrWJ63QSzzHo9kwYUUBEkm5SxKxIG/TopT32j29N65XgWV6uWoB4ltpKi
+8zbp8fiuzkkOr4VubTgGY0zzehTvUZj8pHNVV89vrsxjM+gqHvmjKg2CxwzwoBBgDF9h4PvHAuX
ToauG2J8S2FJXbviqe2a9mHYuOitgaYK7qtfmM7hZOC9Ah2MbWyDyAdTYgII76euExdclVVslX9W
SF8zNoQQPgPXmTpRsdfWz3WDTM3UBcTx9PLQmgc1WsjLgJ1OzQU7TYLans8QlYIkaWc81OiKXE1g
bHmRS1IN0ZxqUc1bJGxazWGj3aWPcaXn1xKyWluHtziMeR4Ux655E26nftl3Gdq+R1EZpnP80e9s
6w5683euOPeW+Qoz5SvMPzGm9tAzlEkOOmTMZsHNHJU1vImz6Vbyd2B7+XHrl+2FFJn9rQEpytbe
tKxQ2yDIf/9MbxIoJQ2FhN1Q3A3pkmEOQF7OAvhUP3fgpm2WYTWNa01sJ3geNvWm6ZjkXZHxCNAG
dL25ayV3KyLNXojgZv6yguOTBMmUU7SXbw1XUtDO6/0PKT1iY/bb8Iz+P0/G+rTJWjlSxQNa+VfT
YVMRfdy4utRb2ifyYNIshiXw+jW4pGd9o25c9OmVGtlwnTyVHOrWSqUCkhkEFBsTx7UBXjgRtkvg
d/JESAslWbKiVtL0BdEqg8tO9329c5aKTtr5G+91CtfxgcUQqUI4DHFYOiHqBTiaB97eVxVvQZEa
QSbYr4+6l/ZP95ldf2gdfCrSf3OnXwSTG5kh/iJwoRU4swhzoXmHK+Fs4OHFSpEWj5OGkKWhdJQ0
FH9OvGQM42UoPSq3JeaQ+q/F3P++8hyq9H8jGWkQgl/fgoE3oE+xLOnS4X6IfRRzeBP489nueZHE
zck/mixfj9MfAAA=

--Boundary-00=_ajJg/WQfVNa7D5m
Content-Type: application/x-gzip;
  name="q3second.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="q3second.txt.gz"

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
H7l39OnTJzBxPY+UltHz60py8eg/nHHaeJ4aAAA=

--Boundary-00=_ajJg/WQfVNa7D5m--

