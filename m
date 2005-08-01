Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261324AbVHASGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261324AbVHASGr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 14:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVHASGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 14:06:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27084 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261324AbVHASGl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 14:06:41 -0400
Date: Mon, 1 Aug 2005 14:06:39 -0400
From: Dave Jones <davej@redhat.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq on Toshiba Portege 4000?
Message-ID: <20050801180639.GA8530@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <200508012156.18271.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508012156.18271.arvidjaar@mail.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 09:56:17PM +0400, Andrey Borzenkov wrote:
 > Toshiba documentation claims it supports speedstep technology. It has Ali 
 > chipset and PIII CPU:
 > 
 > {pts/1}% lspci
 > 00:00.0 Host bridge: ALi Corporation M1644/M1644T Northbridge+Trident (rev 01)
 > 00:01.0 PCI bridge: ALi Corporation PCI to AGP Controller
 > 00:02.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
 > 00:04.0 IDE interface: ALi Corporation M5229 IDE (rev c3)
 > ...
 > 
 > Any cnahce to use cpufreq (or compatible) technique here?

Nope, The speedstep-smi driver only works on Intel chipsets.

		Dave

