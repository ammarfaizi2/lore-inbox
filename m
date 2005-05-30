Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261656AbVE3RsR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261656AbVE3RsR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 13:48:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261657AbVE3RsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 13:48:17 -0400
Received: from smtp.ciberdimensao.com ([62.48.194.144]:58077 "HELO
	smtp.madinfo.pt") by vger.kernel.org with SMTP id S261656AbVE3RsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 13:48:07 -0400
From: "Clemente Aguiar" <caguiar@madeiratecnopolo.pt>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Adaptec AIC-79xx HostRaid
Date: Mon, 30 May 2005 18:48:01 +0100
Message-ID: <6A0C419392D7BA45BD141D0BA4F253C776F2@loureiro.madeiratecnopolo.pt>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, May 30, 2005 at 06:13:03PM +0100, Clemente Aguiar wrote:
>> 
>> Hello,
>> 
>> We have acquired some IBM xServers which have an integrated raid
controller
>> based on the Adaptec AIC-79xx U320 SCSI controller (called HostRaid).
>> 
>> Is there already support for HostRaid? Are there drivers for it?
>> >From which kernel version and where do I find it in the config?
>
>HostRaid is just software RAID; you can ignore it and let Linux use the
>underlying SCSI devices via the standard aic79xx driver.
>
>	Jeff

What do you mean it is just software RAID? Can you explain?
On the servers there is a configuration option to enable HostRaid, and when
I turn that option ON the mirroring between the two discs start and after a
while they are mirrored.
I think that in terms of performance it should be better to used the
"on-board" HostRaid facility.
Don't you think so?

Clemente

