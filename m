Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJRJ57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJRJ57 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 05:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUJRJyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 05:54:36 -0400
Received: from out008pub.verizon.net ([206.46.170.108]:6137 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S265795AbUJRJwK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 05:52:10 -0400
Message-ID: <41739249.6050705@verizon.net>
Date: Mon, 18 Oct 2004 05:52:09 -0400
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Patch to drivers/video/Kconfig [4 of 4]
References: <41738EF2.3030701@verizon.net> <Pine.GSO.4.61.0410181145090.23486@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.61.0410181145090.23486@waterleaf.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [209.158.211.53] at Mon, 18 Oct 2004 04:52:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:

>On Mon, 18 Oct 2004, Jim Nelson wrote:
>  
>
>>Fix undefined symbol errors in "make config" on architectures that do
>>not have I2C (sparc, primarily)
>>    
>>
>
>Why doesn't SPARC have i2c? If it has PCI and nVidia (and some other) graphics
>cards, it has i2c.
>
>  
>

It isn't included in arch/sparc/Kconfig.  Would it be better to enable 
I2C in the main SPARC Kconfig and mark it experimental until someone 
with a SPARC32 PCI system gets a chance to test it?  My SPARC system is 
SBus.
