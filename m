Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262653AbRFNNy1>; Thu, 14 Jun 2001 09:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262684AbRFNNyR>; Thu, 14 Jun 2001 09:54:17 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:14028 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262653AbRFNNyB>; Thu, 14 Jun 2001 09:54:01 -0400
Message-ID: <3B28C1F2.3090604@sponsera.com>
Date: Thu, 14 Jun 2001 09:53:54 -0400
From: "Christopher B. Liebman" <liebman@sponsera.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-ac10+kdb+acpi i686; en-US; 0.7) Gecko/20010316
X-Accept-Language: en
MIME-Version: 1.0
To: Marco <biancio@club-internet.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: hda timeout (busy)
In-Reply-To: <20010614140728.A1826@bianciotto.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco wrote:

> Hello, here is my problem :
> 
> [1.] 2.4.x kernels sends hda: status timeout: status=0xd0 { Busy }
> errors
> 
> [2.] I have tried some 2.4.x kernels (2.4.0, 2.4.4, and now
> 2.4.5, from debs). They all produce the same error message : 
> Jun 14 13:32:19 debian kernel: hda: status timeout: status=0xd0 { Busy }
> Jun 14 13:32:19 debian kernel: ide0: reset: success
> It happens often but irregularly. It does not occur with 2.2 kernels.

[snip]

Are you running with ACPI enabled *and* ide with dma enabled?  I can 
hang my system regularly that way...  disabling acpi processor power 
states (really state C3) or disabling ide dma gives me a system that 
won't hang....

   -- Chris

