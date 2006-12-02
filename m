Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162972AbWLBMKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162972AbWLBMKV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 07:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162973AbWLBMKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 07:10:20 -0500
Received: from mail1.key-systems.net ([81.3.43.253]:64667 "HELO
	mailer2-1.key-systems.net") by vger.kernel.org with SMTP
	id S1162972AbWLBMKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 07:10:19 -0500
Message-ID: <45716D28.5000708@scientia.net>
Date: Sat, 02 Dec 2006 13:10:16 +0100
From: Christoph Anton Mitterer <calestyo@scientia.net>
User-Agent: Icedove 1.5.0.8 (X11/20061124)
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: data corruption with nvidia chipsets and IDE/SATA drives // memory
 hole mapping related bug?!
References: <4570CF26.8070800@scientia.net> <20061202051720.GA12580@tuatara.stupidest.org>
In-Reply-To: <20061202051720.GA12580@tuatara.stupidest.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> Heh, I see this also with an Tyan S2866 (nforce4 chipset).  I've been
> aware something is a miss for a while because if I transfer about 40GB
> of data from one machine to another there are checksum mismatches and
> some files have to be transfered again.
>   
It seems that this may be occur on _all_ nvidia chipsets (of course I'm
talking about mainboard chips ;) )
Which harddisk types to you use (vendor an interface type)

> I've kept quite about it so far because it's not been clear what the
> cause is and because i can mostly ignore it now that I checksum all my
> data and check after xfer that it's sane (so I have 2+ copies of all
> this stuff everywhere).
>   
I assume that a large number of users actually experience this error,..
but as it's so rare only few correctly identify it.
Most of them might think that its filesystem related or so.



>> The corrupted data is not one single completely wrong block of data
>> or so,.. but if you look at the area of the file where differences
>> are found,.. than some bytes are ok,.. some are wrong,.. and so on
>> (seems to be randomly).
>>     
>
> For me it seems that a single block in the file would be bad and the
> rest OK --- we I'm talking about 2 random blocks in 30BG or so.
>   
Did you check this with an hex editor? I did it an while the errors were
restricted to one "region" of a file.... it was not so that that region
was completely corrupted but only some single bytes.
Actually it was that mostly one bit was wrong,..


Chris.
