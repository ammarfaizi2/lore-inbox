Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267377AbTAGNrE>; Tue, 7 Jan 2003 08:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267375AbTAGNrE>; Tue, 7 Jan 2003 08:47:04 -0500
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:63426 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S267377AbTAGNrD> convert rfc822-to-8bit;
	Tue, 7 Jan 2003 08:47:03 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Asterisk mailing list <asterisk@marko.net>
Subject: DTMF noise
Date: Tue, 7 Jan 2003 14:55:32 +0100
User-Agent: KMail/1.4.1
Cc: Kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301071455.32489.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

when dialing out from the D-link MGCP phone (they actually work now - most of 
the time), I get lots of DTMF noise whenever the other person talks. I only 
get this from the MGCP phone - not with MSN messenger. This seems to be an 
error in isdn4linux falsely detecting DTMF in speech with Asterisk creating 
the actual noise.

This testing has been done on hhe following cards (from lspci)

02:09.0 Network controller: Cologne Chip Designs GmbH ISDN network controller 
[HFC-PCI] (rev 02)
02:0a.0 Network controller: Cologne Chip Designs GmbH ISDN network controller 
[HFC-PCI] (rev 02)
02:0b.0 Network controller: Cologne Chip Designs GmbH ISDN network controller 
[HFC-PCI] (rev 02)

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

