Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751220AbWBJKT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbWBJKT1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 05:19:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWBJKT1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 05:19:27 -0500
Received: from loadbalancer1.core.taytron.net ([80.190.249.152]:23300 "EHLO
	taytron.net") by vger.kernel.org with ESMTP id S1751220AbWBJKT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 05:19:26 -0500
Message-ID: <04cc01c62e2b$724a2110$be02010a@bln.nativeinstruments.de>
From: "Florian Schirmer" <jolt@tuxbox.org>
To: "Manu Abraham" <abraham.manu@gmail.com>, "Adrian Bunk" <bunk@stusta.de>
Cc: <v4l-dvb-maintainer@linuxtv.org>, <linux-kernel@vger.kernel.org>
References: <20060210004643.GL3524@stusta.de> <43EC26E1.5020804@gmail.com>
Subject: Re: [v4l-dvb-maintainer] Re: [2.6 patch] drivers/media/dvb/bt8xx/: make2 structs static
Date: Fri, 10 Feb 2006 11:19:15 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

looks good. Thanks.

Signed-off-by: Florian Schirmer <jolt@tuxbox.org>

Best,
  Florian

----- Original Message ----- 
From: "Manu Abraham" <abraham.manu@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Cc: <v4l-dvb-maintainer@linuxtv.org>; <linux-kernel@vger.kernel.org>
Sent: Friday, February 10, 2006 6:38 AM
Subject: [v4l-dvb-maintainer] Re: [2.6 patch] drivers/media/dvb/bt8xx/: 
make2 structs static


> Adrian Bunk wrote:
>> This patch makes two needlessly global structs static.
>>
>>
>> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>>
>> ---
>>
>>  drivers/media/dvb/bt8xx/bt878.c |    2 +-
>>  drivers/media/dvb/bt8xx/dst.c   |    2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/bt878.c.old 
>> 2006-02-09 22:09:00.000000000 +0100
>> +++ linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/bt878.c 2006-02-09 
>> 22:09:07.000000000 +0100
>> @@ -382,7 +382,7 @@
>>  EXPORT_SYMBOL(bt878_device_control);
>>  -struct cards card_list[] __devinitdata = {
>> +static struct cards card_list[] __devinitdata = {
>>  { 0x01010071, BTTV_BOARD_NEBULA_DIGITV, "Nebula Electronics DigiTV" },
>>  { 0x07611461, BTTV_BOARD_AVDVBT_761, "AverMedia AverTV DVB-T 761" },
>> --- linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/dst.c.old 
>> 2006-02-09 22:09:21.000000000 +0100
>> +++ linux-2.6.16-rc2-mm1-full/drivers/media/dvb/bt8xx/dst.c 2006-02-09 
>> 22:09:29.000000000 +0100
>> @@ -602,7 +602,7 @@
>>  */
>>  -struct dst_types dst_tlist[] = {
>> +static struct dst_types dst_tlist[] = {
>>  {
>>  .device_id = "200103A",
>>  .offset = 0,
>>
>> -
>>
>
>
> Ack'd-by: Manu Abraham <manu@linuxtv.org>
>
>
> _______________________________________________
> v4l-dvb-maintainer mailing list
> v4l-dvb-maintainer@linuxtv.org
> http://www.linuxtv.org/cgi-bin/mailman/listinfo/v4l-dvb-maintainer
> 

