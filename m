Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTIIUQE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264492AbTIIUQE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:16:04 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:13142 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264490AbTIIUPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:15:36 -0400
Date: Tue, 9 Sep 2003 21:14:37 +0100
From: Dave Jones <davej@redhat.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Buggy PCI drivers - do not mark pci_device_id as discardable data
Message-ID: <20030909201436.GA1382@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030909204803.N4216@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030909204803.N4216@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 08:48:03PM +0100, Russell King wrote:

 > -static struct pci_device_id agp_ati_pci_table[] __initdata = {
 > +static struct pci_device_id agp_ati_pci_table[] = {

Wierd. I could swear akpm had these patches in his tree no so long back.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
