Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267590AbTGHT70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 15:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267572AbTGHT5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 15:57:48 -0400
Received: from dsl2.external.hp.com ([192.25.206.7]:21774 "EHLO
	dsl2.external.hp.com") by vger.kernel.org with ESMTP
	id S265297AbTGHT4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 15:56:49 -0400
Date: Tue, 8 Jul 2003 14:11:23 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       alan@lxorguk.ukuu.org.uk, grundler@parisc-linux.org,
       James.Bottomley@SteelEye.com, axboe@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode II
Message-ID: <20030708201123.GA6787@dsl2.external.hp.com>
References: <20030702235619.GA21567@wotan.suse.de> <1057263988.21508.18.camel@dhcp22.swansea.linux.org.uk> <20030703212415.GA30277@wotan.suse.de> <20030707.191438.71104854.davem@redhat.com> <20030708213427.39de0195.ak@suse.de> <20030708194744.GD17115@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030708194744.GD17115@gtf.org>
User-Agent: Mutt/1.3.28i
X-Home-Page: http://www.parisc-linux.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 03:47:44PM -0400, Jeff Garzik wrote:
> Personally, I've always thought we were kidding ourselves by not doing
> the error checking you describe. 

Amen. When I pointed this out a few years back, it was made it clear this
was a design choice : not providing a return value was simpler for driver
writers. I agree it's simpler and don't pretend to know what's best
for other driver writers. Sounds like a topic for 2.7 though.

grant
