Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUBIWOL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 17:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUBIWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 17:14:10 -0500
Received: from smtp07.auna.com ([62.81.186.17]:27871 "EHLO smtp07.retemail.es")
	by vger.kernel.org with ESMTP id S265233AbUBIWOH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 17:14:07 -0500
Date: Mon, 9 Feb 2004 23:14:05 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Jean-Luc Fontaine <jfontain@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: i2c erroneous temperatures from sensors
Message-ID: <20040209221405.GA6011@werewolf.able.es>
References: <4027D2E6.7070706@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <4027D2E6.7070706@free.fr> (from jfontain@free.fr on Mon, Feb 09, 2004 at 19:35:18 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.09, Jean-Luc Fontaine wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>
...
> 
> # sensors
> w83697hf-isa-0290
> Adapter: ISA adapter
> Algorithm: ISA algorithm
> VCore:     +1.62 V  (min =  +0.06 V, max =  +0.03 V)
> +3.3V:     +3.31 V  (min =  +0.14 V, max =  +0.00 V)
> +5V:       +5.08 V  (min =  +0.11 V, max =  +0.00 V)
> +12V:     +11.86 V  (min =  +0.97 V, max =  +9.73 V)
> - -12V:      +1.13 V  (min =  -4.22 V, max =  -4.38 V)
> - -5V:       +2.09 V  (min =  -7.71 V, max =  -7.71 V)
> V5SB:      +5.62 V  (min =  +5.43 V, max =  +0.27 V)
> VBat:      +0.06 V  (min =  +0.03 V, max =  +1.28 V)
> fan1:     2700 RPM  (min =   -1 RPM, div = 2)
> fan2:        0 RPM  (min = 168750 RPM, div = 2)
> temp1: +280 C (high =  +400 C, hyst =  +120 C) sensor = thermistor
> 
> temp2: +345.0 C (high = +1200 C, hyst = +1200 C) sensor = thermistor
> 

Update userspace tools to 2.8.4. Also check sensors.conf and uncomment
all settings for your chip, there are no more builtin defaults...

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
