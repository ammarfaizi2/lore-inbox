Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265609AbUAJX5P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 18:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbUAJX5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 18:57:15 -0500
Received: from ns.clanhk.org ([69.93.101.154]:12935 "EHLO mail.clanhk.org")
	by vger.kernel.org with ESMTP id S265609AbUAJX5O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 18:57:14 -0500
Message-ID: <40003BB1.2010709@clanhk.org>
Date: Sat, 10 Jan 2004 17:51:45 +0000
From: "J. Ryan Earl" <heretic@clanhk.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: gene.heskett@verizon.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Q re /proc/bus/i2c
References: <200401100117.42252.gene.heskett@verizon.net> <200401100754.47752.gene.heskett@verizon.net> <3FFFE8E4.8080004@clanhk.org> <200401101556.01736.gene.heskett@verizon.net>
In-Reply-To: <200401101556.01736.gene.heskett@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett wrote:

>>Even with 2.6, you need to install the lm-sensors package, but not
>>the i2c package as the kernel already has everything needed in it. 
>>The lm-sensors packages contains drivers for all the sensor chips. 
>>After you get lm-sensors installed on your current kernel, run
>>sensors-detect to get the proper modules loaded for your hardware.
>>
>>-ryan
>>    
>>
>
>Reread the README in lm_sensors-2.8.2.  I've followed that, except 
>that a make user_install apparently only goes thru the motions 
>without reporting any errors.
>
>Been there, done that, a dozen times maybe?
>  
>

OK, I'm going to try this on 2.6.  The sensor I use isn't in the kernel: 
asb100 (Asus's ASIC).

I know for a fact the 2.6 doesn't support nearly as many sensors as the 
lm-sensors package, but I never tried getting it all setup on 2.6 since 
2.6 hasn't been stable enough for what I needed it for.  I thought that 
lm-sensors merely used the in-kernel i2c interface but provided it's own 
driver modules.  I realize that the documentation says to build only the 
user utilities, but I thought that was just an error.  I let portage 
take care of all the details.

-ryan

