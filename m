Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265231AbUBEORD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 09:17:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUBEORD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 09:17:03 -0500
Received: from tristate.vision.ee ([194.204.30.144]:62180 "HELO mail.city.ee")
	by vger.kernel.org with SMTP id S265231AbUBEORB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 09:17:01 -0500
Message-ID: <4022505B.1020900@vision.ee>
Date: Thu, 05 Feb 2004 16:16:59 +0200
From: =?ISO-8859-1?Q?Lenar_L=F5hmus?= <lenar@vision.ee>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20040205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-mm1 aka "Geriatric Wombat"
References: <20040205014405.5a2cf529.akpm@osdl.org> <200402051357.04005.s0348365@sms.ed.ac.uk>
In-Reply-To: <200402051357.04005.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:

>On Thursday 05 February 2004 09:44, Andrew Morton wrote:
>  
>
>Still doesn't boot on my nForce 2 system, hangs while probing PDC RAID card. 
>Confirmed from 2.6.2-rc3-mm1 that it was likely related to ACPI changes, but 
>reverting bk-acpi.patch makes no difference.
>
>I'd like to test mainline, but I'm using gcc 3.4 snapshot, so I'll try later 
>today with 2.6.2 + linus.patch.
>
>  
>
Same here, hangs probing hpt366 ide controller. After some time says:

hde: lost interrupt

boots ok with pci=noacpi

Lenar
