Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135250AbREESi2>; Sat, 5 May 2001 14:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135248AbREESiT>; Sat, 5 May 2001 14:38:19 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:13307 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S135250AbREESiE>; Sat, 5 May 2001 14:38:04 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Linux 2.4.4-ac5; hpt370 & new dma setup
Date: Sat, 5 May 2001 14:37:53 -0400
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01050514375300.14219@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

thunder7@xs4all.nl wrote:

> On Fri, May 04, 2001 at 11:24:58PM +0100, Alan Cox wrote:
>> 
>> ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
>> 
>> Intermediate diffs are available from
>> 
>> http://www.bzimage.org
>> 
>> Please test this code **carefully** if using an HPT366/370 IDE controller as
>> there are driver changes there. Otherwise its mostly just catching up with
>> the bugfixes.
>> 
>> 2.4.4-ac5
>> o	Fix DMA setup on hpt366/370			(Tim Hockin)
> 
> I see definite changes; on heavy disk-access I got the following:
> 
> hdg: timeout waiting for dma
> ide_dmaproc: chipset supported ide_dma_timeout func only:14
> hdg: irq timeout: status = 0x58 { DriveReady SeekComplete DataRequest}
> 
> this was repeated several times, and ide3 was being reset, but the
> kernel hung anyway after 5 minutes of waiting.
> 
> I must have an unlucky set of hardware (via chipset VP6 board, Live!,
> ibm drives).

Funny I have had the same problem with 2.4.4 only with a pdc20267 (reported
to lkml with topic '[BUG] pdc20267 and dma timeouts')  Is there some problem 
with resets on ide2/3?

TIA
Ed Tomlinson <tomlins@cam.org>

Ed Tomlinson
