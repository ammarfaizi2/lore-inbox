Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292368AbSB0MZR>; Wed, 27 Feb 2002 07:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292378AbSB0MZI>; Wed, 27 Feb 2002 07:25:08 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:22427 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S292370AbSB0MY4>; Wed, 27 Feb 2002 07:24:56 -0500
Date: Wed, 27 Feb 2002 13:24:54 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@mandrakesoft.com,
        linux-net@vger.kernel.org
Subject: Re: [BETA] First test release of Tigon3 driver
Message-ID: <20020227132454.B24996@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020227120549.A8734@stud.ntnu.no> <20020227.033455.13771237.davem@redhat.com> <20020227125611.A20415@stud.ntnu.no> <20020227.040653.58455636.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227.040653.58455636.davem@redhat.com>; from davem@redhat.com on Wed, Feb 27, 2002 at 04:06:53AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> Please, simply make tg3_read_partno always return 0 (or,
> alternatively, make tg3_get_invariants() ignore tg3_read_partno's
> return value).  It should just work, this string is not critical to
> the driver's operation.

Do you want a dump of the vpd_data it receives?  Here's the dmesg line after
the driver is loaded:

tg3.c:v0.90 (Feb 25, 2002)
eth1: Tigon3 [partno() rev 7102 PHY(5401)] (PCI:66MHz:64-bit) 10/100/1000BaseT Ethernet 00:06:5b:05:f9:8e

The machine is a Dell PowerEdge 2550 machine, running RedHat Linux 7.2 (with
2.4.18 kernel).  Let me know if you want me to run any specific tests, it's
connected to a Cisco switch with gigabit-ports (so I can actually test
things like jumboframes if needed).

-- 
Thomas
