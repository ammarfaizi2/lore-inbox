Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750770AbWHFXU3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750770AbWHFXU3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:20:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbWHFXU3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:20:29 -0400
Received: from vcs5.camavision.com ([63.228.164.252]:59868 "EHLO
	marajade.camavision.com") by vger.kernel.org with ESMTP
	id S1750771AbWHFXU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:20:28 -0400
Message-ID: <44D6792C.1060502@squeakycode.net>
Date: Sun, 06 Aug 2006 18:20:12 -0500
From: andy <andy@squeakycode.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: asus m5n, i2c-i805 missing temp1_auto_temp_min
References: <44D6383E.7050000@squeakycode.net> <20060806224715.2bfe074a.khali@linux-fr.org>
In-Reply-To: <20060806224715.2bfe074a.khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean Delvare wrote:
> Hi Andy,
> 
>> I have an asus m5n laptop, with kernel 2.6.16.9, and this works:
>>
>> if cd '/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e'; then
>>      echo 55000 > temp1_auto_temp_min
>>      echo 50000 > temp1_auto_temp_off
>> fi
>>
>> However in kernel 2.6.16.27, and 2.6.17.7 it does not.  It reports that 
>> directory is not found (I can get to '/sys/devices/pci0000:00/' and 
>> thats it).  Its only for setting the fan on/off temp's, so its not a big 
>> deal, but it makes my laptop quieter when its not doing anything, so I 
>> kinda like it.
>>
>> Is there a new way of doing this?  Or was it moved to another module? 
>> Or broken?
> 
> Done on purpose.
> 
> Please see this thread:
> http://lkml.org/lkml/2006/7/26/249
> 

Ahh yes, thank you very much.  I'm now the proud owner of a 2.6.17.7 kernel.

-Andy
