Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316900AbSFVU5L>; Sat, 22 Jun 2002 16:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316897AbSFVU5K>; Sat, 22 Jun 2002 16:57:10 -0400
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:6158 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316893AbSFVU5J>; Sat, 22 Jun 2002 16:57:09 -0400
Date: Sat, 22 Jun 2002 22:57:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Douglas Gilbert <dougg@torque.net>
cc: Roman Zippel <zippel@linux-m68k.org>, David Brownell <david-b@pacbell.net>,
       Nick Bellinger <nickb@attheoffice.org>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] /proc/scsi/map
In-Reply-To: <3D14D9F1.8B88668F@torque.net>
Message-ID: <Pine.LNX.4.44.0206222247020.8911-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 22 Jun 2002, Douglas Gilbert wrote:

> Trying to clear up the nomenclature here, according to SAM-2
> ( www.10.org ) target ports have mandatory "identifiers"
> and optional "names". The WWUI in iSCSI is part of the
> target _identifier_. SAM-2 is pretty vague about "names"
> but it does note that for a logical unit, its _name_
> may be reported in the Device Identification VPD page in
> an INQUIRY.

iSCSI currently specifies two types of names:
1. iSCSI Qualified Name: contains a date, domain and an arbitrary name,
   e.g. "iqn.2001-04.com.acme.diskarrays-sn-a8675309"
2. IEEE EUI-64 format: an IEEE assigned name, e.g.
   "eui.02004567A425678D"

bye, Roman

