Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRCZTTX>; Mon, 26 Mar 2001 14:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132550AbRCZTTN>; Mon, 26 Mar 2001 14:19:13 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11392 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132547AbRCZTS7>;
	Mon, 26 Mar 2001 14:18:59 -0500
Message-ID: <3ABF95F8.84508E68@mandrakesoft.com>
Date: Mon, 26 Mar 2001 14:18:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@udc.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problems with Wake on LAN
In-Reply-To: <20010326210846.A1182@manty.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Garcia Mantinan wrote:
> 
> Hi!
> 
> I've been trying to get Wake on LAN working under kernel 2.4.2 with a 3COM
> 3c905C-TX card, standard 2.4.2 drivers, I have manage to get it working, but
> only if I don't compile ACPI and I don't load the network card driver, as
> any of this things make the Wake on LAN not work. APM and other features
> don't seem to affect the card waking, but this two really break it.
> 
> Is there any plan on solving any of this for the future?
> 
> Is there anything I can do to help get this working?

Are you using Becker's ftp://www.scyld.com/pub/diag/ether-wake.c ?

Did you turn on the enable_wol module option?  Note that might be a new
option in the 2.4.3-preXX series...

-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full moon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
