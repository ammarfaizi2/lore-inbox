Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbTK3Jjc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 04:39:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263666AbTK3Jjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 04:39:32 -0500
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:48079 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id S263452AbTK3Jjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 04:39:31 -0500
Date: Sun, 30 Nov 2003 09:38:39 +0200 (MET DST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
X-X-Sender: szaka@ua178d119.elisa.omakaista.fi
To: Arjan van de Ven <arjanv@redhat.com>
cc: Andrew Clausen <clausen@gnu.org>, John Bradford <john@grabjohn.com>,
       Andries Brouwer <aebr@win.tue.nl>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
In-Reply-To: <1070182676.5214.2.camel@laptop.fenrus.com>
Message-ID: <Pine.LNX.4.58.0311300910500.2329@ua178d119.elisa.omakaista.fi>
References: <20031128045854.GA1353@home.woodlands>  <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org>  <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
  <20031129123451.GA5372@win.tue.nl>  <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
  <20031129223103.GB505@gnu.org> <1070182676.5214.2.camel@laptop.fenrus.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 30 Nov 2003, Arjan van de Ven wrote:

> EFI GPT has some severe downsides (like requiring the last sector on
> disk, which in linux may not be accessible if the total number of
> sectors is not a multiple of 2, and making dd of one disk to another
> impossible if the second one is bigger)

Isn't this Linux's shortcoming? NT could always access odd last sectors.
Actually in the majority of cases it stores the backup of its boot sector
in the last sector of the partition for recovery purpose (outside of NTFS).

Anton made a fix for this years ago. It's PITA (and wasting time)
explaining and working around constantly how Linux can (not) access it.

Is it fixed in 2.6?

	Szaka
