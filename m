Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbTKOSJx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 13:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTKOSJx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 13:09:53 -0500
Received: from imap.gmx.net ([213.165.64.20]:45765 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261885AbTKOSJv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 13:09:51 -0500
X-Authenticated: #4512188
Message-ID: <3FB66C9F.8070008@gmx.de>
Date: Sat, 15 Nov 2003 19:12:47 +0100
From: "Prakash K. Cheemplavam" <prakashpublic@gmx.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: de-de, de, en-us, en
MIME-Version: 1.0
To: Marcus Hartig <marcus@marcush.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test9 /-mm3 SATA siimage - bad disk performance
References: <3FB5B74E.5080707@marcush.de> <3FB5EDC1.8010805@gmx.de> <3FB6685A.8010607@marcush.de>
In-Reply-To: <3FB6685A.8010607@marcush.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Hartig wrote:
> Prakash K. Cheemplavam wrote:
> 
>> I have a similar problem: With 2.4.22-ac3 I had 37mb/sec with my 
>> Samsung HD and 49MB/sec with IBM/Hitachi, now with 2.6 (all I tried, 
>> including test9-mm2) I had only 20mb/sec for Samsung and about 
>> 39mb/sec for the IBM. Motherboard is Abit NF7-S Rev2.0, as well, so 
>> same situation with the siimage 1.06 driver. I wanted to run some dd 
>> tests as well, but it is a real performance hit. Playing with 
>> readahead or other hdparm options didn't help either.
> 
> 
> I get a tip from Mark Hahn to set the pci latency to 64. And wow, with 
> fedora 2.4.22 kernel I get then 41MB/sec with max_k_p_r 128. But,... 
> after copying big files I get ext3-fs erros, cannot read inode etc and a
> bus error. Bumm!

Is there a way to change the latency within Linux? I mean I don't want 
to ruin my Windows, as it works w/o problems. Nevertheless I rather make 
a backup of my Linux install before messing with that...

Prakash

