Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262537AbVCaH2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVCaH2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 02:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVCaH2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 02:28:37 -0500
Received: from smtp8.wanadoo.fr ([193.252.22.23]:31466 "EHLO smtp8.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262537AbVCaHXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 02:23:46 -0500
X-ME-UUID: 20050331072344601.92DA71C000F6@mwinf0806.wanadoo.fr
Message-ID: <424BA580.10905@wanadoo.fr>
Date: Thu, 31 Mar 2005 09:23:44 +0200
From: Yves Crespin <crespin.quartz@wanadoo.fr>
Organization: Quartz
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-15?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Disable cache disk
References: <424AA2F0.3090100@wanadoo.fr> <200503301738.39057.linux-kernel@borntraeger.net>
In-Reply-To: <200503301738.39057.linux-kernel@borntraeger.net>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Bornträger wrote:

>On Wednesday 30 March 2005 15:00, Yves Crespin wrote:
>  
>
>>1/ is-it possible to *really* be synchronize. I prefer to have a blocked
>>write() than use cache and get swap!
>>    
>>
>
>Try to mount with the sync option. 
>  
>
exactly async and noatime ?

>  
>
>>2/ is-it possible to disable cache disk ?
>>    
>>
>
>your copy tool has to support/use O_DIRECT
>  
>
is O_DIRECT a POSIX option ?
http://www.opengroup.org/onlinepubs/007908799/xsh/open.html
Is O_SYNC also necessary ?

