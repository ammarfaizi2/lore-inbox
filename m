Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317302AbSGIRVy>; Tue, 9 Jul 2002 13:21:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSGIRVx>; Tue, 9 Jul 2002 13:21:53 -0400
Received: from [62.70.58.70] ([62.70.58.70]:33414 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S317302AbSGIRVx> convert rfc822-to-8bit;
	Tue, 9 Jul 2002 13:21:53 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Chris Friesen <cfriesen@nortelnetworks.com>, jbradford@dial.pipex.com
Subject: Re: Recoverable RAM Disk
Date: Tue, 9 Jul 2002 19:24:23 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <200207091619.RAA00228@darkstar.example.net> <3D2B11FA.65A92E40@nortelnetworks.com>
In-Reply-To: <3D2B11FA.65A92E40@nortelnetworks.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200207091924.23242.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only tricky bit is that I don't know if a warm boot on a PC wipes ram
> or not...

Normally it does, but in the old days, you could - in DOS DEBUG or somewhere 
set 0040:0072 to a given value and then jmp f000:fff0.

IIRC, the value in 0040:0072 was these:

0x0000:	cold reboot
0x1234:	warm reboot
0x5678:	warm reboot without memory clear

hæpp

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

