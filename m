Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269423AbTCDRGT>; Tue, 4 Mar 2003 12:06:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269424AbTCDRGT>; Tue, 4 Mar 2003 12:06:19 -0500
Received: from palrel12.hp.com ([156.153.255.237]:34750 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id <S269423AbTCDRGS>;
	Tue, 4 Mar 2003 12:06:18 -0500
Date: Tue, 4 Mar 2003 09:16:40 -0800
To: Patrick Mochel <mochel@osdl.org>
Cc: Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com, jt@hpl.hp.com,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       mika.penttila@kolumbus.fi
Subject: Re: [PATCH] pcmcia: get initialization ordering right [Was: [PATCH 2.5] : i82365 & platform_bus_type]
Message-ID: <20030304171640.GA16366@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20030304095447.GA1408@brodo.de> <Pine.LNX.4.33.0303040831120.992-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0303040831120.992-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 04, 2003 at 08:35:05AM -0600, Patrick Mochel wrote:
> 
> This patch is completley untested, but it should work. 

	I think you are hitting the nail on the head, various people
are doing many "obvious" changes all over the place without bothering
to check them, resulting in non functional code.
	That's not the way I want to work, and that's why I won't
commit the new Wireless Extensions stuff until I can really test it.

> 	-pat

	Thanks.

	Jean
