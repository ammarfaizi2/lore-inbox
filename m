Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262057AbSI3Pmj>; Mon, 30 Sep 2002 11:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262109AbSI3Pmi>; Mon, 30 Sep 2002 11:42:38 -0400
Received: from 62-190-219-230.pdu.pipex.net ([62.190.219.230]:14720 "EHLO
	nemesis.cube") by vger.kernel.org with ESMTP id <S262057AbSI3Pmh>;
	Mon, 30 Sep 2002 11:42:37 -0400
Message-ID: <3D98722D.5050503@walrond.org>
Date: Mon, 30 Sep 2002 16:47:57 +0100
From: Andrew Walrond <andrew@walrond.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020831
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: IDE Problems with 2.5.39
References: <3D9775BF.3090504@walrond.org> <1033337141.9053.6.camel@I401.resi.insa-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nope; This is the latest Asus PR-DLS dual Xeon motherboard with

ServerWorks^® Grand Champion LE North Bridge (CMIC-LE)
ServerWorks^® Champion South Bridge (CSB5)
ServerWorks^® 64-bit PCI-X Bridge (CIOB-X2)

And the Serverworks IDE driver doesn't see my drive.
Works Fine with 2.4.20-pre8

Who should I be talking to?

JF wrote:

>On Sun, 2002-09-29 at 23:50, Andrew Walrond wrote:
>  
>
>>Hi,
>>
>>I can't boot with 2.5.39 because the built-in  ide driver (ServerWorks 
>>CSB5) can't see hda, and VFS says "Cannot open root device "hda3" or 
>>03:03" which results in a kernel panic
>>
>>Works fine with 2.4.20-pre? with identical kernel setup and kernel 
>>parameter root=/dev/hda3
>>
>>Is this a known problem? Any way around it or patches?
>>    
>>
>
>I used to have this problem with 2.5 too
>It went from the IDE controller chipset.
>
>Are you sure that you have only 1 IDE controller chipset ?
>
>I have both PIIX4 and HPT366. Root FS is on HPT366 controller. Enabling
>only PIIX4 used to work with 2.4 but doesn't with 2.5 anymore (got
>exactly your problem). I had to enable specific support for both.
>
>I suppose your root FS is on a specific IDE controller for which the
>support is not enabled (check the different type in the IDE/ATA kernel
>config section)
>
>Regards.
>
>  
>


