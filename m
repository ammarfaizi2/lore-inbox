Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266150AbUAVKAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUAVKAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:00:09 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:8320 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266150AbUAVKAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:00:03 -0500
Date: Thu, 22 Jan 2004 10:08:06 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200401221008.i0MA866G000176@81-2-122-30.bradfords.org.uk>
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1074759964.12536.65.camel@laptop-linux>
References: <1074735774.31963.82.camel@laptop-linux>
 <20040121234956.557d8a40.akpm@osdl.org>
 <200401220813.i0M8DX4Q000511@81-2-122-30.bradfords.org.uk>
 <1074759964.12536.65.camel@laptop-linux>
Subject: Re: PATCH: Shutdown IDE before powering off.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Nigel Cunningham <ncunningham@users.sourceforge.net>:
> 
> --=-1L1FlHM683Yn00jU9UMu
> Content-Type: text/plain
> Content-Transfer-Encoding: quoted-printable
> 
> Hi.
> 
> On Thu, 2004-01-22 at 21:13, John Bradford wrote:
> > > This spins down the disk(s) when you're just doing do a reboot.  That's
> > > fairly irritating and could affect reboot times if one has many disks.
> >=20
> > I think it is an attempt to force some broken drives to flush their
> > cache, but I wonder whether it will simply move the problem from one
> > set of broken drives to another :-).
> 
> Yes, they were trying to get caches flushed. If this attempt is
> misguided, that's fine. Is there a better way?

It was discussed at length around the 2.4.20 timeframe, when the
power-off cache-flush and spin down behavior was changed, but I don't
remember any real conclusion being reached.

John.
