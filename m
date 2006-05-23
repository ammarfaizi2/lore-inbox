Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWEWJaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWEWJaz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 05:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWEWJaz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 05:30:55 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:32749 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932143AbWEWJaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 05:30:55 -0400
Date: Tue, 23 May 2006 11:30:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: i386 Kconfig options out of order
In-Reply-To: <9451.1148364620@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0605231127550.17704@scrub.home>
References: <9451.1148364620@kao2.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 23 May 2006, Keith Owens wrote:

> Options NUMA and EFI in arch/i386/Kconfig depend on ACPI but they
> appear before the ACPI option.  make oldconfig with no initial setting
> for CONFIG_ACPI will prompt for these options, but if you then say No
> to CONFIG_ACPI the options will silently be turned off.

That's the normal behaviour.

>  Conversely if
> you turn on CONFIG_ACPI you do not get prompted for the options that
> are out of order.

What exactly did you do? It works fine here.
Note that due to the "default y" the other options are visible before 
ACPI.

bye, Roman
