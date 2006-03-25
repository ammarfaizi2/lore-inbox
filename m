Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWCYTFw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWCYTFw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 14:05:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWCYTFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 14:05:52 -0500
Received: from fe1.cox-internet.com ([66.76.2.38]:63158 "EHLO fe1.coxmail.com")
	by vger.kernel.org with ESMTP id S932248AbWCYTFv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 14:05:51 -0500
Message-ID: <44259489.4070507@tamu.edu>
Date: Sat, 25 Mar 2006 13:05:45 -0600
From: Benjamin <benchu@tamu.edu>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Modify the sock Structure!!
References: <4424ED2A.3040006@tamu.edu> <Pine.LNX.4.61.0603251938110.29793@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603251938110.29793@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cool! Thanks for the answer!

Best Regards,

Benjamin Chu

Jan Engelhardt wrote:
>> Hello! I try to modify the sock Structure in sock.h in order to record some
>> data!
>> I just add a unsigned short in the end of the structure. such as:
>>
>> struct sock {
>>     
>
>   
>> safe or not. Is there any side-effect? Or I need to add additional code to
>> avoid some unexpected
>> situation?  Thank you very much!
>>     
>
>
> Should be ok. For example, ipt_TPROXY/ipt_tproxy also adds something to 
> struct sock (including enlarging fields in the middle of the struct);
> I have not experienced any problem with it.
>
>
> Jan Engelhardt
>   
