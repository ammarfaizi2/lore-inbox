Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262459AbTCMRwD>; Thu, 13 Mar 2003 12:52:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCMRwD>; Thu, 13 Mar 2003 12:52:03 -0500
Received: from bitchcake.off.net ([216.138.242.5]:44512 "EHLO mail.off.net")
	by vger.kernel.org with ESMTP id <S262459AbTCMRwC>;
	Thu, 13 Mar 2003 12:52:02 -0500
Date: Thu, 13 Mar 2003 13:02:49 -0500
From: Zach Brown <zab@zabbo.net>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
Message-ID: <20030313130249.C4587@bitchcake.off.net>
References: <1047402060.19262.33.camel@irongate.swansea.linux.org.uk> <Pine.LNX.4.30.0303111702170.13969-100000@divine.city.tvnet.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.30.0303111702170.13969-100000@divine.city.tvnet.hu>; from szaka@sienet.hu on Tue, Mar 11, 2003 at 05:29:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 11, 2003 at 05:29:46PM +0100, Szakacsits Szabolcs wrote:

> Randy's compliler is 2.96 and it forgot to do a 'sub $0xc,%esp'. See
> yourself all the data at http://bugme.osdl.org/show_bug.cgi?id=432

we definitely ran into this in Lustre, too:

	https://lxr.lustre.org/source/configure.in#027
	https://lxr.lustre.org/source/lib/obd_pack.c#049

- z
