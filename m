Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311214AbSCLO1C>; Tue, 12 Mar 2002 09:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311213AbSCLO0w>; Tue, 12 Mar 2002 09:26:52 -0500
Received: from smtp2.vol.cz ([195.250.128.42]:18962 "EHLO smtp2.vol.cz")
	by vger.kernel.org with ESMTP id <S311211AbSCLO0l>;
	Tue, 12 Mar 2002 09:26:41 -0500
Date: Mon, 11 Mar 2002 21:34:39 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Message-ID: <20020311203438.GD332@elf.ucw.cz>
In-Reply-To: <20020310180526.GA1135@darkside.ddts.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020310180526.GA1135@darkside.ddts.net>
User-Agent: Mutt/1.3.27i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


> With this patch applied and CONFIG_ACPI_NO_GPE_DISABLE #define'd,
> Keyboard-Power-ON as well as Wake-On-LAN are working for me,
> without this patch or with CONFIG_ACPI_NO_GPE_DISABLE #undef'ined,
> both don't work.

I guess this needs to be runtime-configurable at least. It is probably
bug. Introducing the config option is not right fix.
								Pavel

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
