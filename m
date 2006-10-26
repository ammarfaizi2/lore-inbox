Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422960AbWJZKfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422960AbWJZKfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423018AbWJZKfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:35:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:15057 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1422960AbWJZKfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:35:42 -0400
Message-ID: <45408F71.1030909@anagramm.de>
Date: Thu, 26 Oct 2006 12:35:29 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gregory Brauer <greg@wildbrain.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA300 TX4 + WD2500KS = status=0x50 { DriveReady SeekComplete
 }
References: <453FD6B5.9080205@wildbrain.com>
In-Reply-To: <453FD6B5.9080205@wildbrain.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:224ad0fd4f2efe95e6ec4f0a3ca8a73c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Gregory!

Gregory Brauer wrote:
> 
> I have a new Promise SATA300 TX4 4-port SATA controller
> to which I have attached two older WD2500JD hard drives
> and two brand new WD2500KS hard drives.  The older drives
> seem to work fine, but both of the brand new hard drives
> trigger the following errors every few seconds during
> i/o:
> 
> Oct 25 13:57:18 gleep kernel: ata3: no sense translation for status: 0x50
> Oct 25 13:57:18 gleep kernel: ata3: translated ATA stat/err 0x50/00 to 
> SCSI SK/ASC/ASCQ 0xb/00/00
> [...]
> 00:0b.0 Mass storage controller: Promise Technology, Inc. PDC20718 (SATA 
> 300 TX4) (rev 02)

Hummm... Well, first, can you try another kernel?
Second, the same chip on a board from a different manufacturer.
I am a hardware engineer working with the Promise PDC20775.
SATA Chips are pretty sensitive to bad board layout, coming up
with strange errors. :-/

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19

