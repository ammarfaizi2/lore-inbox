Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261732AbVEULxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbVEULxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 07:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEULxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 07:53:19 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:33451 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261732AbVEULxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 07:53:15 -0400
Date: Sat, 21 May 2005 13:49:33 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Greg KH <greg@kroah.com>
cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove the obsolete raw driver
In-Reply-To: <20050521053558.GA23542@kroah.com>
Message-ID: <Pine.LNX.4.61.0505211348010.997@scrub.home>
References: <20050521001925.GQ5112@stusta.de> <20050521053558.GA23542@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 20 May 2005, Greg KH wrote:

> On Sat, May 21, 2005 at 02:19:25AM +0200, Adrian Bunk wrote:
> > Since kernel 2.6.3 the Kconfig text explicitely stated this driver was 
> > obsolete.
> > 
> > It seems to be time to remove it.
> 
> As much as I would like to agree with you, no, not yet.  Mark it as
> going to go away in the Documenation/feature-removal.txt file 6-8 months
> from now (or longer if people object, but no longer than a year) and
> then after that time expires, we can delete it.

Adding a warning message to the open function would be nice too.
Which user really reads that file?

bye, Roman
