Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTFYOS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264491AbTFYOS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:18:29 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:45243
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264490AbTFYOS2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:18:28 -0400
Date: Wed, 25 Jun 2003 10:32:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Mark Watts <m.watts@eris.qinetiq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Finding out what cards a driver supports...
Message-ID: <20030625143239.GA11244@gtf.org>
References: <200306251453.02690.m.watts@eris.qinetiq.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306251453.02690.m.watts@eris.qinetiq.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 02:53:02PM +0100, Mark Watts wrote:
> How would I find out what network cards a particular driver supports? 
> (particularly the tg3 / bcm5700 driver in 2.4.x)

Look in the PCI ids table, and compare that with the output of 'lspci -n' 
for your card.

	Jeff



