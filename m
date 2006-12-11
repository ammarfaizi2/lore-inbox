Return-Path: <linux-kernel-owner+w=401wt.eu-S1762382AbWLKDsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762382AbWLKDsw (ORCPT <rfc822;w@1wt.eu>);
	Sun, 10 Dec 2006 22:48:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762394AbWLKDsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Dec 2006 22:48:52 -0500
Received: from gate.crashing.org ([63.228.1.57]:54482 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762382AbWLKDsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Dec 2006 22:48:50 -0500
Subject: Re: [PATCH 0/6] PCI-X/PCI-Express read control interfaces
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061208182241.786324000@osdl.org>
References: <20061208182241.786324000@osdl.org>
Content-Type: text/plain
Date: Mon, 11 Dec 2006 14:48:32 +1100
Message-Id: <1165808912.7260.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 10:22 -0800, Stephen Hemminger wrote:
> This patch set adds hooks to set PCI-X max read request size
> and PCI-Express read request size. It is important that this be a PCI
> subsystem function rather than a per device hack. That way, the PCI
> system quirks can be used if needed.

Excellent, I've been needing that to work around bogus firmwares...

Ben.


