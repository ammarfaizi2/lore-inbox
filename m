Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262171AbVFHLXg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262171AbVFHLXg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262172AbVFHLXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:23:36 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:43932 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S262171AbVFHLXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:23:33 -0400
Message-ID: <42A6D521.606@ens-lyon.org>
Date: Wed, 08 Jun 2005 13:23:13 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Johannes Stezenbach <js@linuxtv.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.12-rc6
References: <Pine.LNX.4.58.0506061104190.1876@ppc970.osdl.org> <20050607091144.GA5701@linuxtv.org> <20050608111503.GA5777@linuxtv.org>
In-Reply-To: <20050608111503.GA5777@linuxtv.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Stezenbach a écrit :
> Johannes Stezenbach wrote:
> 
>>Hype-threading stopped working for me (probably due to
>>me not enabling ACPI). dmesg output and .config attached.
>>-rc5 worked fine. The board is an Asus P4P800-Deluxe.
>>
>>dmesg: WARNING: 1 siblings found for CPU0, should be 2
> 
> 
> Indeed SMT works fine if I enable ACPI.
> Is SMT without ACPI not supported?
> 
> Johannes

You can pass acpi=ht into the kernel command line to disable
ACPI except the minimum required to get HT support.

>From Documentation/kernel-parameters.txt:
acpi=       [HW,ACPI] Advanced Configuration and Power Interface
            ...
            ht -- run only enough ACPI to enable Hyper Threading

Brice
