Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264692AbTF0S05 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264695AbTF0S05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:26:57 -0400
Received: from host-64-213-145-173.atlantasolutions.com ([64.213.145.173]:4992
	"EHLO havoc.gtf.org") by vger.kernel.org with ESMTP id S264692AbTF0S04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:26:56 -0400
Date: Fri, 27 Jun 2003 14:41:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] remove IO APIC newline
Message-ID: <20030627184111.GB4333@gtf.org>
References: <200306271836.h5RIakGD026159@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306271836.h5RIakGD026159@hera.kernel.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 27, 2003 at 04:43:13PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1490.1.28, 2003/06/27 09:43:13-07:00, randy.dunlap@verizon.net
> 
> 	[PATCH] remove IO APIC newline
> 	
> 	This patch is to 2.5.73-bk4 and is purely cosmetic.  Please apply.
> 	It removes the blank line after "testing the IO APIC....":

Personally the IO-APIC gunk is gunk that should be hidden behind
DPRINTK... SMP machines spam dmesg _way_ too much.  Especially once you
get above 4 processors.

	Jeff



