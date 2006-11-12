Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753335AbWKLWIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbWKLWIX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 17:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753334AbWKLWIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 17:08:23 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:42458 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753335AbWKLWIW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 17:08:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DlnuvhgNf49fICB2R/Uf0WM6F/L7CRNXsiNKS7KLG6aW2xRJA0ZvGz4YqphURDhQcjwmCb7YIQ4Jnel+Ys5hDx/uEIuAvZR6ORDcHBnkAGwL69k8iGGBy0/2ywsaakZDtOYLbXpa22dvR3VjayrDngVMYDJfQQXX1ajBzEZsggs=
Message-ID: <5a4c581d0611121408y5dee562bmc44dcffaf2040747@mail.gmail.com>
Date: Sun, 12 Nov 2006 23:08:21 +0100
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Shawn Starr" <shawn.starr@rogers.com>
Subject: Re: ieee80211 & ipw2200 (ipw2100) issues
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200611121213.20582.shawn.starr@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200611121213.20582.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
