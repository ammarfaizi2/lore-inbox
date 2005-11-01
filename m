Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVKAE7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVKAE7i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 23:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbVKAE7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 23:59:38 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:31906 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S932578AbVKAE7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 23:59:38 -0500
Date: Mon, 31 Oct 2005 21:03:57 -0800
From: thockin@hockin.org
To: "Martin J. Bligh" <mbligh@mbligh.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Message-ID: <20051101050357.GA15949@hockin.org>
References: <20051027205921.M81949@linuxwireless.org> <1130447261.5416.20.camel@blade> <20051027211203.M33358@linuxwireless.org> <20051027220533.GA18773@redhat.com> <1130451071.5416.32.camel@blade> <20051027221253.GA25932@redhat.com> <1130451421.5416.35.camel@blade> <20051027221756.M55421@linuxwireless.org> <1130711165.32734.11.camel@localhost.localdomain> <12100000.1130799788@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12100000.1130799788@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 03:03:08PM -0800, Martin J. Bligh wrote:
> > Wrong IA-32 supports more than 4Gb in PAE 36bit physical 32bit virtual
> > mode and has done since the Preventium Pro
> 
> Indeed ... I have 64GB ia32 boxes ;-)

And Intel server chipsets do support remapping.  I've seen boards with 2
GB IO holes remapped above 4 GB.

A 4 GB system reports 6 GB of memory, 4 of which are usable as DRAM.
Intel doesn't document it, but there's a slight performance hit for the
remapped memory, too.
