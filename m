Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268344AbUJTPxL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268344AbUJTPxL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUJTPYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:24:11 -0400
Received: from [195.23.16.24] ([195.23.16.24]:3806 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268370AbUJTPXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:23:18 -0400
Message-ID: <417682D5.2020803@grupopie.com>
Date: Wed, 20 Oct 2004 16:23:01 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
References: <2PjiW-3hl-21@gated-at.bofh.it> (Kendall Bennett's message of "Thu, 14 Oct 2004 21:20:10 +0200") <416E8322.25700.29ACC2F1@localhost>
In-Reply-To: <416E8322.25700.29ACC2F1@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.24; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kendall Bennett wrote:
> Andi Kleen <ak@muc.de> wrote:
> 
> 
>>"Kendall Bennett" <KendallB@scitechsoft.com> writes:
>>
>>>So what do you guys think? 
>>
>>How big is the module with emulator etc.? 
> 
> 
> About 150K compiled on x86 (before linking so that has symbol information 
> etc in it).

I searched for the code in the scitech FTP server... If this code is 
similar to the one found under "../obsolete/.." then it seems that the 
code is somewhat optimized for speed, whereas for video initialization 
we probably could rework it to be optimized for code size.

If the complete interpreter could fit in 64k (or something like that) 
then the chances of it getting into the kernel would be probably higher 
and could solve a lot of problems.

This is a problem I find somewhat interesting, and would be willing to 
give it some of my spare time...

-- 
Paulo Marques -  www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

P.S. Aren't there other uses for a in-kernel x86 interpreter?

