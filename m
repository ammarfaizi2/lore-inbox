Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272052AbTHKFfr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 01:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272057AbTHKFfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 01:35:47 -0400
Received: from [66.212.224.118] ([66.212.224.118]:3599 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272052AbTHKFfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 01:35:41 -0400
Date: Mon, 11 Aug 2003 01:23:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Robert Love <rml@tech9.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, cmrivera@ufl.edu,
       linux-kernel@vger.kernel.org
Subject: Re: /proc/stat's intr field looks odd, although /proc/interrupts
 seems correct
In-Reply-To: <1060577118.684.52.camel@localhost>
Message-ID: <Pine.LNX.4.53.0308110121090.19193@montezuma.mastecende.com>
References: <1060572792.1113.10.camel@boobies.awol.org> 
 <34161.4.4.25.4.1060573727.squirrel@www.osdl.org>  <1060574873.684.41.camel@localhost>
  <34253.4.4.25.4.1060576385.squirrel@www.osdl.org>  <1060576517.684.47.camel@localhost>
  <34268.4.4.25.4.1060576870.squirrel@www.osdl.org> <1060577118.684.52.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Aug 2003, Robert Love wrote:

> On Sun, 2003-08-10 at 21:41, Randy.Dunlap wrote:
> 
> > Um, your turn.
> 
> Hahaha. I don't know, Randy. :)

On i386 you can find out the last irq line number during MP table parsing 
(ACPI bits are also in mpparse.c), for the hotplug case i suppose the 
hotplug code could bump this up as devices get attached. But unless we do 
dynamic NR_IRQs its all just too much effort.

