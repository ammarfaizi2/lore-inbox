Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265465AbUBFOol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 09:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265471AbUBFOol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 09:44:41 -0500
Received: from mail.gmx.de ([213.165.64.20]:39316 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265465AbUBFOok (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 09:44:40 -0500
X-Authenticated: #689055
Message-ID: <4023A822.7050602@gmx.de>
Date: Fri, 06 Feb 2004 15:43:46 +0100
From: Torsten Scheck <torsten.scheck@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
References: <3FD0555F.5060608@gmx.de> <20031205160746.GA18568@codepoet.org>
In-Reply-To: <20031205160746.GA18568@codepoet.org>
X-Enigmail-Version: 0.82.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erik Andersen wrote:
>> On Fri Dec 05, 2003 at 10:52:31AM +0100, Torsten Scheck wrote:
> [...]
>>>I found a critical FAT32 bug when I tried to store data onto an
>>>internal IDE 160 GB and onto an external USB2/FW-250 GB hard
>>>disk.
>> 
>> 
>> Does this help?
>> 
>>  -Erik
> 
> [... int=>loff_t ino,inum-patch ...]
> 
> Hi Erik:
> 
> I applied your patch to 2.4.23 and it solved the problem. No more lost 
> clusters. All data stays where it belongs.
> 
> I'll test it for a few days and get back to you later.
> 
> Thank you very much.
> 
> Torsten


I'm still very content with your patch. As I mainly rsync between an 
ext3 and a vfat 200+GB filesystem, I'm pretty sure that there was no 
single error.

Thanks again.

Torsten

