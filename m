Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282329AbRLKR7s>; Tue, 11 Dec 2001 12:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282418AbRLKR7i>; Tue, 11 Dec 2001 12:59:38 -0500
Received: from mailserv.wright.edu ([130.108.128.60]:13779 "EHLO
	mailserv.wright.edu") by vger.kernel.org with ESMTP
	id <S282329AbRLKR7X>; Tue, 11 Dec 2001 12:59:23 -0500
Date: Tue, 11 Dec 2001 12:59:20 -0500
From: mathews.5@wright.edu
Subject: 
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Message-id: <3C088FE7@mailserv66>
MIME-version: 1.0
X-Mailer: WebMail (Hydra) SMTP v3.61.08
Content-type: multipart/mixed; boundary="Boundary_(ID_AT6SHWXUJvdXtgSeTzm63Q)"
X-EXP32-SerialNo: 00003280
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This is the preamble of a multipart MIME formatted message.
  If you are reading this text your mail system is most likely
  not capable of properly decoding MIME messages.  To extract
  the contents of this message, save it to a file and then use
  an external MIME decoding utility.

--Boundary_(ID_AT6SHWXUJvdXtgSeTzm63Q)
Content-type: text/plain; charset="ISO-8859-1"
Content-transfer-encoding: 7bit

Patched against 2.5.1-pre9: fix to compile order in drivers/media/video, 
specifically for the Zoran 36067 driver. I patched part of the compilation 
order in the 2.4.13-ac8 series, but this was missed. Fixes the Makefile so 
that the various PCI bridge drivers ($CONFIG_VIDEO_ZORAN_BUZ, ..._LML33, 
..._DC10) are compiled into the kernel before the actual zr36067 driver is 
($CONFIG_VIDEO_ZORAN). It's not the best solution, but I couldn't come up with 
anything else that allowed the zr36067 driver to be compiled into the kernel.

Terry Mathews

--Boundary_(ID_AT6SHWXUJvdXtgSeTzm63Q)
Content-type: application/octet-stream; name=patch
Content-transfer-encoding: BASE64
Content-disposition: attachment; filename=patch

LS0tIGRyaXZlcnMvbWVkaWEvdmlkZW8vTWFrZWZpbGUub3JpZwlUdWUgRGVjIDEx
IDEyOjQ4OjEwIDIwMDEKKysrIGRyaXZlcnMvbWVkaWEvdmlkZW8vTWFrZWZpbGUJ
VHVlIERlYyAxMSAxMjo0ODo0OSAyMDAxCkBAIC00NCwxMSArNDQsMTAgQEAKIG9i
ai0kKENPTkZJR19WSURFT19DUUNBTSkgKz0gYy1xY2FtLm8KIG9iai0kKENPTkZJ
R19WSURFT19CV1FDQU0pICs9IGJ3LXFjYW0ubwogb2JqLSQoQ09ORklHX1ZJREVP
X1c5OTY2KSArPSB3OTk2Ni5vCi1vYmotJChDT05GSUdfVklERU9fWk9SQU4pICs9
IHpyMzYwNjcubyBpMmMtb2xkLm8KIG9iai0kKENPTkZJR19WSURFT19aT1JBTl9C
VVopICs9IHNhYTcxMTEubyBzYWE3MTg1Lm8KIG9iai0kKENPTkZJR19WSURFT19a
T1JBTl9EQzEwKSArPSBzYWE3MTEwLm8gYWR2NzE3NS5vCiBvYmotJChDT05GSUdf
VklERU9fWk9SQU5fTE1MMzMpICs9IGJ0ODE5Lm8gYnQ4NTYubwotb2JqLSQoQ09O
RklHX1ZJREVPX0xNTDMzKSArPSBidDg1Ni5vIGJ0ODE5Lm8KK29iai0kKENPTkZJ
R19WSURFT19aT1JBTikgKz0genIzNjA2Ny5vIGkyYy1vbGQubwogb2JqLSQoQ09O
RklHX1ZJREVPX1BNUykgKz0gcG1zLm8KIG9iai0kKENPTkZJR19WSURFT19QTEFO
QikgKz0gcGxhbmIubwogb2JqLSQoQ09ORklHX1ZJREVPX1ZJTk8pICs9IHZpbm8u
bwo=

--Boundary_(ID_AT6SHWXUJvdXtgSeTzm63Q)--
