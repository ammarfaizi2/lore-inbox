Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261810AbREPHYN>; Wed, 16 May 2001 03:24:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261808AbREPHXy>; Wed, 16 May 2001 03:23:54 -0400
Received: from mailout00.sul.t-online.com ([194.25.134.16]:31751 "EHLO
	mailout00.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261810AbREPHXt>; Wed, 16 May 2001 03:23:49 -0400
Date: 16 May 2001 09:17:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <80x0j$9mw-B@khms.westfalen.de>
In-Reply-To: <01051602593001.00406@starship>
Subject: Re: LANANA: To Pending Device Number Registrants
X-Mailer: CrossPoint v3.12d.kh6 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home> <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home> <01051602593001.00406@starship>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

phillips@bonn-fries.net (Daniel Phillips)  wrote on 16.05.01 in <01051602593001.00406@starship>:

> On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
> > Personally, I'd really like to see /dev/ttyS0 be the first detected
> > serial port on a system, /dev/ttyS1 the second, etc.
>
> There are well-defined rules for the first four on PC's.  The ttySx
> better match the labels the OEM put on the box.

Sorry, but that turns out not to be the case.

There are some rules for devices called COMx (x=1..4, ports much more than  
interrupts[1]), but I haven't ever seen a box that had a "ttySx" label  
from the manufacturer. And you can easily renumber those; the BIOS uses a  
4-entry lookup table for the ports.

[1] COM1=3F8, COM2=2F8, COM3=3E8, COM2=2E8

MfG Kai
