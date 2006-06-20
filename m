Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWFTOn1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWFTOn1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 10:43:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751156AbWFTOn1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 10:43:27 -0400
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:65167
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1751154AbWFTOn0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 10:43:26 -0400
Message-ID: <4498098D.6010906@ed-soft.at>
Date: Tue, 20 Jun 2006 16:43:25 +0200
From: Edgar Hucek <hostmaster@ed-soft.at>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based Macs
References: <6pOCE-1Dv-39@gated-at.bofh.it> <E1Fsh6K-0000mJ-L7@be1.lrz>
In-Reply-To: <E1Fsh6K-0000mJ-L7@be1.lrz>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thx, for the hint. As far as i see in the kernel every depency
for macintish imples the power pc architecture. 

cu

Edgar Hucek

Bodo Eggert schrieb:
> Edgar Hucek <hostmaster@ed-soft.at> wrote:
> 
>> +config FB_IMAC
>> +        bool "Intel Based Macs FB"
>> +        depends on (FB = y) && X86
>> +        select FB_CFB_FILLRECT
>> +        select FB_CFB_COPYAREA
>> +        select FB_CFB_IMAGEBLIT
>> +        help
>> +          This is the frame buffer device driver for the Inel Based Mac's
> 
> 1) Speling error: Inel
> 2) Isn't there a macintosch CONFIG option you can depend on?

