Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVAFByP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVAFByP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 20:54:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVAFByP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 20:54:15 -0500
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:42455 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262702AbVAFByL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 20:54:11 -0500
Date: Thu, 6 Jan 2005 02:58:52 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: Nicholas Miell <nmiell@comcast.net>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re:  Re: [PATCH] get/set FAT filesystem attribute bits
In-Reply-To: <1104970545.3810.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501060242130.6323@be1.lrz>
References: <fa.i537e7s.1d6m90c@ifi.uio.no> <fa.ihdqkec.1i5umji@ifi.uio.no>
  <E1CmLBc-0001ZU-00@be1.7eggert.dyndns.org> <1104970545.3810.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Nicholas Miell wrote:
> On Thu, 2005-01-06 at 01:07 +0100, Bodo Eggert wrote:
> > H. Peter Anvin wrote:
> > > By author:    Bodo Eggert <7eggert@gmx.de>

> > >> > a = archive
> > >> 
> > >> Should be the "dump" attribute
> > 
> > > What dump attribute?
> > 
> > The one described in man chattr.
> 
> You mean "no dump (d)", the attribute that says this file should never
> be backed up and is in no way related to the Archive bit, which says
> that this file has been modified since the last time the Archive bit was
> cleared?

It seems I misread the manpage. Dump will by default backup 'no dump'
files if it's not creating an incremental backup, so I asumed it would set
the flag on backup.

