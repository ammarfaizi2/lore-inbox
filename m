Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261391AbVBGKSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261391AbVBGKSd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 05:18:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261393AbVBGKSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 05:18:33 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:15877 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261391AbVBGKS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 05:18:29 -0500
Message-ID: <420740F1.5050609@hist.no>
Date: Mon, 07 Feb 2005 11:20:33 +0100
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: =?UTF-8?B?U3RlZmFuIETDtnNpbmdlcg==?= <stefandoesinger@gmx.at>,
       acpi-devel@lists.sourceforge.net,
       Ondrej Zary <linux@rainbow-software.org>,
       Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@ucw.cz>,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ncunningham@linuxmail.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
References: <20050122134205.GA9354@wsc-gmbh.de>	 <4204B3C1.80706@rainbow-software.org>	 <9e473391050205074769e4f10@mail.gmail.com>	 <200502051748.43547.stefandoesinger@gmx.at> <9e47339105020509382adbbf39@mail.gmail.com>
In-Reply-To: <9e47339105020509382adbbf39@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>On Sat, 5 Feb 2005 17:48:43 +0100, Stefan Dösinger
><stefandoesinger@gmx.at> wrote:
>  
>
>>The reset code of radeon card seems to be easy to reverse engineer. I have
>>started an attempt and I have 50-60% of my radeon M9 reset code implemented
>>in a 32 bit C program. I had to stop due to school reasons.
>>    
>>
>
>The problem with the radeon reset code is that there are many, many
>variations of the radeon chips, including different steppings of the
>same part. The ROM is matched to the paticular bugs of the chip. From
>what I know ATI doesn't even have a universal radeon reset program.
>  
>
Maybe they could provide such a program, if asked?
Basically, a chip detect and a switch statement containing all
the bios reset sequences they have.

They may want to protect "trade secrets" about innovative
3D-pipelines and such.  But the bios reset is probably not that
high-end, so perhaps they could provide source code for it?

Helge Hafting
