Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262855AbUJ1G3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262855AbUJ1G3V (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 02:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbUJ1G1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 02:27:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7382 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262855AbUJ1GZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 02:25:45 -0400
Date: Thu, 28 Oct 2004 02:25:38 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <linux-acpi@intel.com>
Subject: Re: Fw: Re: 2.6.10-rc1-mm1
In-Reply-To: <200410271702.17086.bjorn.helgaas@hp.com>
Message-ID: <Xine.LNX.4.44.0410280225110.13421-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Bjorn Helgaas wrote:

> I did find a couple places that unregister the driver even when
> acpi_bus_register_driver() fails, which could cause this.  But I
> really doubt that this is the problem, because the only error
> returns there are for "acpi_disabled" and "!driver".  Patch is
> attached anyway if you want to try it.

This looks to have fixed the problem.


- James
-- 
James Morris
<jmorris@redhat.com>


