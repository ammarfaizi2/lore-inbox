Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbWGRQHy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbWGRQHy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 12:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbWGRQHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 12:07:54 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:31966 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751354AbWGRQHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 12:07:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AcV6ukWHgq9VguVALJNvv72PgdvPKswGvzmWAtDthDJ/1XXpw9rfLLmvWJJ6ponFwjLbJFRLAWfxp2abez7ShNqm3c42Qq+84isN/mby/dx249IRKXeDcuS4WCbQXPGiOwBvHQpoDltffvQLBlIvxgvdpf7TzLMj13mNNBfowdc=
Message-ID: <44BD075F.1020202@gmail.com>
Date: Tue, 18 Jul 2006 10:07:59 -0600
From: Jim Cromie <jim.cromie@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060516)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] drivers/char/pc8736x_gpio.c: remove unused static
 functions
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <20060715003743.GQ3633@stusta.de>
In-Reply-To: <20060715003743.GQ3633@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Thu, Jul 13, 2006 at 10:48:00PM -0700, Andrew Morton wrote:
>   
>> ...
>> Changes since 2.6.18-rc1-mm1:
>> ...
>> +gpio-drop-vtable-members-gpio_set_high-gpio_set_low.patch
>> ...
>>  Misc fixes and updates and cleanups.
>> ...
>>     
>
> This patch removes two no longer used static functions fixing the 
> following gcc warnings:
>
> <--  snip  -->
>
> ...
>   CC      drivers/char/pc8736x_gpio.o
> drivers/char/pc8736x_gpio.c:192: warning: #pc8736x_gpio_set_high# defined but not used
> drivers/char/pc8736x_gpio.c:197: warning: #pc8736x_gpio_set_low# defined but not used
> ...
>
> <--  snip  -->
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
>   
yes please. and thanks.

Acked-by:   Jim Cromie   <jim.cromie@gmail.com>

( I delayed this reply, thinking it unnecessary to ack an obviously 
correct patch.
Then rethought, figuring for explicit closure instead of tacit agreement. )



FYI, Im currently using these patches on -mm2, cursory tests show no 
regressions.
# Adrian's trims
scx200_gpio.c-make-code-static.eml    (my edited/reversed-effect version)
drivers_char_pc8736x_gpio.c-remove-unused-static-functions.eml
# Chris Boot's led patches
scx200_gpio-export-cleanups.eml
net48xx-led-use-gpio-ops.patch


