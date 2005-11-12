Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbVKLCVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbVKLCVd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:21:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbVKLCVd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:21:33 -0500
Received: from main.gmane.org ([80.91.229.2]:26330 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751319AbVKLCVc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:21:32 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Highpoint IDE types
Date: Sat, 12 Nov 2005 04:15:02 +0200
Message-ID: <pan.2005.11.12.02.15.00.646462@sci.fi>
References: <1131471483.25192.76.camel@localhost.localdomain> <pan.2005.11.08.19.02.09.190896@sci.fi> <4374F633.6020006@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181093116.pp.htv.fi
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Cc: linux-ide@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2005 22:51:15 +0300, Sergei Shtylylov wrote:

> Hello.
> 
> Ville Syrjälä wrote:
>> On Tue, 08 Nov 2005 17:38:02 +0000, Alan Cox wrote:
> 
>>>Ok thanks to Sergei I can now post what I think is the complete table of
>>>HPT chip versions:
> 
>     Another correction coming in... :-)
> 
>>>        Chip                    PCI ID          Rev
>>> *      HPT366                  4 (HPT366)      0
>>> *      HPT366                  4 (HPT366)      1    
>>> *      HPT368                  4 (HPT366)      2      
>>> *      HPT370                  4 (HPT366)      3      
>>> *      HPT370A                 4 (HPT366)      4      
>>> *      HPT372                  4 (HPT366)      5     
>>> *      HPT372N                 4 (HPT366)      6     
>>> *      HPT372                  5 (HPT372)      0
>> 
>>           ^^^^^^
>> 
>> This one is called HPT372A by Highpoint's BIOS/Win drivers.
> 
>     According to Highpoint's driver code 372A has rev. ID 1...
> 
>> Also I'm not sure if it's relevant but PCI ID 5 chips use a different
>> BIOS image than PCI ID 4 chips.
>>        
>> 
>>> *      HPT372N                 5 (HPT372)      > 0     
> 
>     And 372N has rev. ID 2...

Right you are. Their opensource driver doesn't list any PCI ID 5,6 or 7
chips with revision 0. All rev 1 chips are apparently non-N models and all
rev 2 chips are N models.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


