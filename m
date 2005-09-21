Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750979AbVIUOQJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750979AbVIUOQJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 10:16:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVIUOQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 10:16:09 -0400
Received: from [195.23.16.24] ([195.23.16.24]:1425 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S1750980AbVIUOQI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 10:16:08 -0400
Message-ID: <43316B1F.6010106@grupopie.com>
Date: Wed, 21 Sep 2005 15:15:59 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bgs <bgs@bgs.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: probs with realtek 8110/8169 NIC
References: <4331229D.9050302@bgs.hu>
In-Reply-To: <4331229D.9050302@bgs.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bgs wrote:
>  Greetings,
> 
> I installed a NIC with a 8110/8169 chip in a server to upgrade to 
> gigabgit bandwidth. I get a lot of these in dmesg:

My best guess from the little information available is that this looks 
like 4k stacks being used together with reiserfs and a stack overflow 
corrupting the stack away.

Your .config would be helpful to confirm this, though.

I would suggest you turn CONFIG_4KSTACKS off or use a different filesystem.

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
