Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263460AbTIWTPK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:15:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTIWTOn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:14:43 -0400
Received: from havoc.gtf.org ([63.247.75.124]:6591 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263425AbTIWTKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:10:19 -0400
Date: Tue, 23 Sep 2003 15:10:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: "Luck, Tony" <tony.luck@intel.com>, "David S. Miller" <davem@redhat.com>,
       davidm@hpl.hp.com, davidm@napali.hpl.hp.com, peter@chubb.wattle.id.au,
       ak@suse.de, iod00d@hp.com, peterc@gelato.unsw.edu.au,
       linux-ns83820@kvack.org, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030923191011.GA6460@gtf.org>
References: <DD755978BA8283409FB0087C39132BD101B01194@fmsmsx404.fm.intel.com> <20030923142925.A16490@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030923142925.A16490@kvack.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Traditionally, if the NIC driver is accessing unaligned data, it should
be using get/put_unaligned().

	Jeff



