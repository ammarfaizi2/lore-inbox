Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267414AbSLLEzv>; Wed, 11 Dec 2002 23:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267416AbSLLEzv>; Wed, 11 Dec 2002 23:55:51 -0500
Received: from pop015pub.verizon.net ([206.46.170.172]:24544 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S267414AbSLLEzu>; Wed, 11 Dec 2002 23:55:50 -0500
Message-ID: <3DF818D1.8@verizon.net>
Date: Thu, 12 Dec 2002 00:04:17 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.51 - Strange UP APIC / 8139too / USB issues
References: <3DF7A706.3020600@verizon.net>
In-Reply-To: <3DF7A706.3020600@verizon.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at pop015.verizon.net from [64.223.83.18] at Wed, 11 Dec 2002 23:03:32 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Correction:

The problem is actually ACPI.  With ACPI disabled, both USB and network
function correctly with local APIC + IO-APIC enabled or disabled.

Sorry for the red herring.

- Steve

Stephen Wille Padnos wrote:
[snip]

> I finally found the culprit - "Local APIC Support on Uniprocessors" 
> and "IO-APIC on uniprocessors".  If both items are enabled, the 
> network functions, but USB doesn't work.  If not both are enabled 
> (neither, or Local APIC but not IO-APIC), then the USB system works, 
> but the network doesn't.  :( 

[snip]


