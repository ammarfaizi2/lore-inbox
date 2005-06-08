Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVFHRNd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFHRNd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVFHRNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:13:17 -0400
Received: from colo.lackof.org ([198.49.126.79]:58333 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S261386AbVFHRLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:11:00 -0400
Date: Wed, 8 Jun 2005 11:14:40 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Andi Kleen <ak@suse.de>
Cc: Greg KH <gregkh@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, Roland Dreier <roland@topspin.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>, tom.l.nguyen@intel.com
Subject: Re: [Penance PATCH] PCI: clean up the MSI code a bit
Message-ID: <20050608171440.GD5908@colo.lackof.org>
References: <20050608063559.GA22869@suse.de> <20050608134109.GW23831@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050608134109.GW23831@wotan.suse.de>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 03:41:09PM +0200, Andi Kleen wrote:
> I disagree it should stay as it is. Basically you are trading
> a bit less complexity in Infiniband now for a lot of code everywhere.

It's not just infiniband. It's tg3 and e1000 as well.

grant
