Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289730AbSBESMf>; Tue, 5 Feb 2002 13:12:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289727AbSBESMS>; Tue, 5 Feb 2002 13:12:18 -0500
Received: from AMontpellier-201-1-6-182.abo.wanadoo.fr ([80.13.220.182]:30479
	"EHLO awak") by vger.kernel.org with ESMTP id <S289730AbSBESL7> convert rfc822-to-8bit;
	Tue, 5 Feb 2002 13:11:59 -0500
Subject: Re: driverfs support for motherboard devices
From: Xavier Bestel <xavier.bestel@free.fr>
To: Pavel Machek <pavel@suse.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20020205173912.GA165@elf.ucw.cz>
In-Reply-To: <20020205173912.GA165@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Feb 2002 19:11:31 +0100
Message-Id: <1012932692.27241.15.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le mar 05-02-2002 à 18:39, Pavel Machek a écrit :

> +void __init device_init_sys(void)
> +{
> +     sprintf(sys_iobus.name,"Bus for motherboard and strange devices");

Don't you fear that, with such a vague name, it'll end up being used as
a generic thing where all not-well-defined hacks will end ? (à la
procfs)

	Xav

