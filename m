Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755158AbWKMQk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755158AbWKMQk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755200AbWKMQk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:40:28 -0500
Received: from web88002.mail.re2.yahoo.com ([206.190.37.189]:64371 "HELO
	web88002.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1755158AbWKMQk0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:40:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=aqqo/0G+usS/+Lzc4ftFx1LAIopGe97qiwv1dJwF+hStOHLT+XJPjTG0JJf6iKbIImy4OxsK630WfrLayf7tI538Kdw7FB6ojVtX0uhybBOqtZUmRUl4Q7fN8Mg7YP3pTCmGt/UBGIq49i0m7ZDisonjuRrQjWAgqaBMvhwCKtg=  ;
Message-ID: <20061113164025.78522.qmail@web88002.mail.re2.yahoo.com>
Date: Mon, 13 Nov 2006 08:40:25 -0800 (PST)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: Re: ieee80211 & ipw2200 (ipw2100) issues
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With WPA2? I have to confirm if things are still broken with ipw2200 1.1.4. I wish this was sorted out. Really, the developers seem to have vanished afaik.

----- Original Message ----
From: Alessandro Suardi 
To: Shawn Starr 
Cc: linux-kernel
Sent: Sunday, November 12, 2006 5:08:21 PM
Subject: Re: ieee80211 & ipw2200 (ipw2100) issues

On 11/12/06, Shawn Starr <shawn.starr@rogers.com> wrote:
> I would like to know when the Intel people working on the ipw2200 will merge
> 1.2.0 into vanilla? If it's not in vanilla is this present in akpm's -mm
> tree?
>
> The version in vanilla right now doesn't work with WPA and doesn't work with
> the newst firmware.

I'm writing this email on a VPN link over a WPA-enabled
 connection on my ipw2200 wifi card, FC6-uptodate
 with 2.6.19-rc5-git2:

[asuardi@sandman ~]$ dmesg | grep -i ipw
ipw2200: Intel(R) PRO/Wireless 2200/2915 Network Driver, 1.1.4kmpr
ipw2200: Copyright(c) 2003-2006 Intel Corporation
ipw2200: Detected Intel PRO/Wireless 2200BG Network Connection
ipw2200: Detected geography ZZD (13 802.11bg channels, 0 802.11a channels)
[asuardi@sandman ~]$ ps ax| grep wpa
 2852 ?        Ss     0:00 wpa_supplicant -B -Dwext -ieth1 -c
/etc/wpa_supplicant/wpa_supplicant.conf
 4816 pts/2    S+     0:00 grep wpa
[asuardi@sandman ~]$ rpm -q wpa_supplicant
wpa_supplicant-0.4.9-1.fc6
[asuardi@sandman ~]$ uname -a
Linux sandman 2.6.19-rc5-git2 #2 Thu Nov 9 20:05:41 CET 2006 i686 i686
i386 GNU/Linux

What combo isn't working for you ?

> Are there plans to change the ipw cards to use the new softmac subsystem?

--alessandro

"...when I get it, I _get_ it"

     (Lara Eidemiller)



