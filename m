Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261349AbSJHVwp>; Tue, 8 Oct 2002 17:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263130AbSJHVvo>; Tue, 8 Oct 2002 17:51:44 -0400
Received: from floyd.blarg.net ([206.124.128.8]:39915 "EHLO mail.blarg.net")
	by vger.kernel.org with ESMTP id <S261349AbSJHVu1>;
	Tue, 8 Oct 2002 17:50:27 -0400
From: Ian Eure <ieure@debian.org>
Reply-To: Ian Eure <ieure@debian.org>
To: linux-kernel@vger.kernel.org
Subject: Clock drift & other weirdness with an Inspirion 8100
Date: Tue, 8 Oct 2002 14:53:48 -0700
User-Agent: KMail/1.4.3
Organization: Debian
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_OHNO6MWABG42JWUHM1KZ"
Message-Id: <200210081453.48645.ieure@debian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_OHNO6MWABG42JWUHM1KZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit

I have a relatively new Dell Inspiron 8100 which is exhibiting some strange 
symptoms. Firstly, there is massive clock drift. The system clock seems to 
run too slow, losing several hours a day.

Secondly, I can't seem to play any video on it. Both mplayer and xine lose 3-5 
frames every 45 seconds or so. Xine shows this semi-helpful output:

-- snip --
200 frames delivered, 0 frames skipped, 0 frames discarded
audio_out: adjusting master clock 1093958 -> 1105016
video_out : throwing away image with pts 1096023 because it's too old (diff : 
95
16 > 1501).
video_out : throwing away image with pts 1099026 because it's too old (diff : 
65
13 > 1501).
video_out : throwing away image with pts 1102029 because it's too old (diff : 
35
10 > 1501).
200 frames delivered, 0 frames skipped, 3 frames discarded
-- snip --

The line about 'adjusting master clock' would seem to indicate that there is 
some disparity with the timing that is causing frames to be dropped. This is 
not a problem with the player, since both mplayer and xine play the same 
files on a slower system just fine.

I've disabled power management & SpeedStep in the BIOS, to no avail. Does 
anyone have a clue what's wrong here?

Please CC on replies, since I'm not subscribed, and I can't seem to locate a 
place to put a Mail-Followup-To header in KMail.

-- 
"das ist liebe, das ist hass / mit eifersucht vermahlen"
--------------Boundary-00=_OHNO6MWABG42JWUHM1KZ
Content-Type: application/pgp-keys;
  name="my pgp key"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=public_key.asc

-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

mQGiBDlqRIgRBACFQZCugwVUEi6TbujE43jAvdXfCh99GPErqQG6l8lOIhvGBCwo
zV/5AyQ3Fsn9lSUfusgzWzGBQT2ZerrELhB9SSQKoEW9e2Qn/y/yEt7ozrV1fWbv
VEPyIfTeg9EAO2ixOF72iW1e3Y9rBHPyNqAR4/A1WvLFHfEkFX1u0iozqwCg6vCX
VotnyekhqIDXC71+U+eONx0D/A+hR/ykBmDc82f7y+Gpmm7BSB+5mju8sfafe7XG
tDZKHrEGq9yc9FGrgsao7fqt0lK31qj/P0OvNE0Y0QmpEjXv5vFsuPm5BXPjQDTJ
oS9/3kr6pnxdjV/T6W91JU9+1RUqJVea0fK4dqdH4NteDaqD6Ug1g/VtllKLvLda
1DI4A/0Zjfzhbh4jWh8awcozkaNz6ixad4qdURk2clTDLCq8NSZb92tGvQoj+F2U
WxwF3gIFsOg4yDABd4uujicdTBQvn0DE62AVyUTkOzRmgBsKwafc2Br9kSg7xHPo
p/q0nurxl3z/cGmB9zQyAya7qH551CYITVHu1qKovR52GuHR8rQbSWFuIEV1cmUg
PGlldXJlQGRlYmlhbi5vcmc+iF0EExECAB0FAj2gvLIFCQYXq6oFCwcKAwQDFQMC
AxYCAQIXgAAKCRAcly8slHrBat2cAJ43Gt7nYPwgeQnWCuq8KPJZFs6pAQCffhp3
VAJjiba2pv17Wr/kmoroAjiIRgQQEQIABgUCPaDw1wAKCRCwkq3BIT7tdv4OAKCl
OPm7NFafCe1JT+H2HzrBnivneACgr0/jZk+5qCp+uBPw/50IxVkAd3C5AQ0EOWpE
wxAEAN5LJkCwqavgS0e6fCcraTIc7WdNsuprVTbn7j81yeYx2g/oH5S9zQ+PvdXz
WtnIBqmFBCGzlPXKs9eR0PQwLaoC97YbDg2fZdAlKp8M9VP+f/oubqLfd1nC81aJ
V7mSA+JoSFoP/MK1fgY+yONug2Lk1/0YSikrIwPs1QZTanI/AAURBACCMGteP+81
1+EbBt87azDzM3qXgh+De2G8aOAM4rDYZXNxsoepDXi68wm4PC07/1fgWApxlAzo
M+vMlIHCv4fmCpEiYYHG1lVV1vs8JCLgYLvqBkvwxolDji+yif/zGlCjCc+Mfh1W
ERx9VxgiWQSD8chzlxdosKf0X0V1ZAJOHohMBBgRAgAMBQI7x2YZBQkEPlTWAAoJ
EByXLyyUesFq17wAmwWaBuR0sEL2tUOtHzEwIPaOMlFpAKCeSflkVdwZArHq/Eih
3qQCpj86cA==
=8mv6
-----END PGP PUBLIC KEY BLOCK-----

--------------Boundary-00=_OHNO6MWABG42JWUHM1KZ--

