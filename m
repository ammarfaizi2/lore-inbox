Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316606AbSGHQLW>; Mon, 8 Jul 2002 12:11:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316991AbSGHQLV>; Mon, 8 Jul 2002 12:11:21 -0400
Received: from port5.ds1-sby.adsl.cybercity.dk ([212.242.169.198]:22076 "EHLO
	trider-g7.fabbione.net") by vger.kernel.org with ESMTP
	id <S316606AbSGHQLU>; Mon, 8 Jul 2002 12:11:20 -0400
Message-ID: <3D29BA6D.80105@fabbione.net>
Date: Mon, 08 Jul 2002 18:14:37 +0200
From: Fabio Massimo Di Nitto <fabbione@fabbione.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
X-Accept-Language: en
MIME-Version: 1.0
To: Riley Williams <rhw@InfraDead.Org>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre10 DevFS + LVM OOPS
References: <Pine.LNX.4.21.0207072338030.9595-100000@Consulate.UFP.CX>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Riley,
                here are the results:


trider-g7:/tmp# mkdir X
trider-g7:/tmp# cd X
trider-g7:/tmp/X# mv ../X ../Y
trider-g7:/tmp/X# cd `pwd`
bash: cd: /tmp/X: No such file or directory
trider-g7:/tmp/X# lvcreate -L10M -ntest system
lvcreate -- rounding size up to physical extent boundary
lvcreate -- doing automatic backup of "system"
lvcreate -- logical volume "/dev/system/test" successfully created

trider-g7:/tmp/X#

as you can see there was no problem at all "unfortunatly".

Regards
Fabio

Riley Williams wrote:

>Hi Fabio.
>
>  
>
>>this happend creating a new a lv with the command lvcreate -L512M
>>-ntest system It did 3 times in a row then it worked again. What was
>>strange is that I was in one dir and unfortunalty I don't remember
>>which and it was crashing. I changed dir and then it was working. In
>>the first instance I didn't thought about taking notes but atleast I
>>have a full trace (the machine didn't hang or reboot... it is still
>>alive 100%).
>>    
>>
>
>This may be completely off-track but I've seen it cause wierd problems
>in the past, so worth checking - was the directory you were in when the
>machine crashed one that still existed as far as the file system was
>concerned?
>
>  
>



