Return-Path: <linux-kernel-owner+w=401wt.eu-S1161151AbWLUCVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbWLUCVL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161149AbWLUCVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:21:10 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:46325 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161144AbWLUCVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:21:09 -0500
Date: Thu, 21 Dec 2006 02:20:53 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Michael Wu <flamingice@sourmilk.net>
Cc: Dan Williams <dcbw@redhat.com>, Jiri Benc <jbenc@suse.cz>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Message-ID: <20061221022053.GB723@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <1166638371.2798.26.camel@localhost.localdomain> <20061221011526.GB32625@srcf.ucam.org> <200612202057.09545.flamingice@sourmilk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612202057.09545.flamingice@sourmilk.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Network drivers that don't suspend on interface down
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 08:57:05PM -0500, Michael Wu wrote:

(allowing scanning while the interface is down)

> No, it's absolutely a bug. It just so happens that some drivers incorrectly 
> allowed it.

Ok. Would it be reasonable to add warnings to any devices that allow it?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
