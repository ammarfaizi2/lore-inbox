Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVDMSxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVDMSxx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVDMSxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 14:53:53 -0400
Received: from ns1.suse.de ([195.135.220.2]:36008 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261169AbVDMSxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 14:53:50 -0400
Date: Wed, 13 Apr 2005 20:53:48 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, shai@scalex86.org
Subject: Re: Add pcibus_to_node
Message-ID: <20050413185348.GC22573@wotan.suse.de>
References: <Pine.LNX.4.58.0504121413510.10332@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504121413510.10332@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 02:16:17PM -0700, Christoph Lameter wrote:
> Define pcibus_to_node to be able to figure out which NUMA node contains a
> given PCI device. This defines pcibus_to_node(bus) in
> include/linux/topology.h and adjusts the macros for i386 and x86_64 that
> already provided a way to determine the cpumask of a pci device.
> 
> x86_64 was changed to not build an array of cpumasks anymore. Instead an
> array of nodes is build which can be used to generate the cpumask via
> node_to_cpumask.

Ok from my side.

-Andi
