Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935651AbWK1G1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935651AbWK1G1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 01:27:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935655AbWK1G1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 01:27:54 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33442 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S935651AbWK1G1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 01:27:53 -0500
Date: Tue, 28 Nov 2006 01:27:47 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: i686 apicid_to_node compile failure.
Message-ID: <20061128062746.GA30889@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

arch/i386/mach-generic/built-in.o: In function `apicid_to_node':
include/asm/mach-summit/mach_apic.h:90: undefined reference to `apicid_2_node'

config is at http://people.redhat.com/davej/.config

		Dave

-- 
http://www.codemonkey.org.uk
