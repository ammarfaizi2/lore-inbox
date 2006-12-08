Return-Path: <linux-kernel-owner+w=401wt.eu-S1760808AbWLHS15@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760808AbWLHS15 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 13:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760815AbWLHS14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 13:27:56 -0500
Received: from smtp.osdl.org ([65.172.181.25]:46208 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760808AbWLHS1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 13:27:55 -0500
Message-Id: <20061208182241.786324000@osdl.org>
User-Agent: quilt/0.46-1
Date: Fri, 08 Dec 2006 10:22:41 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] PCI-X/PCI-Express read control interfaces
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds hooks to set PCI-X max read request size
and PCI-Express read request size. It is important that this be a PCI
subsystem function rather than a per device hack. That way, the PCI
system quirks can be used if needed.

-- 

