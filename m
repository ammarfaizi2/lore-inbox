Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265074AbTARVHQ>; Sat, 18 Jan 2003 16:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265081AbTARVHQ>; Sat, 18 Jan 2003 16:07:16 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:46487 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S265074AbTARVHP>;
	Sat, 18 Jan 2003 16:07:15 -0500
Message-ID: <3E29C3E4.4010304@colorfullife.com>
Date: Sat, 18 Jan 2003 22:15:16 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Florent CHANTRET" <florent@chantret.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [INTEL PII BUG] Still SMBALERT# spontaneous shutdown on VAIO
 Serie F
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>Still having the problem of the spontaneous shutdown on a VAIO serie F
>laptop due to a bug in the thermal sensor of the PII celeron. There is no
>ACPI, nor APM, nor I2C / SMBus builded in the kernel.
>  
>
Are you sure that the shutdown is connected to the errata?

The system shutdown is probably triggered by the BIOS SMI handler - SMI 
can interrupt the linux kernel, and the bios takes over control of the 
system.

Are there any bios upgrades for laptop?

--
    Manfred



