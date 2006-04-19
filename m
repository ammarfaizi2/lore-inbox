Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbWDSUY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbWDSUY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:24:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWDSUY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:24:28 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:27602 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751237AbWDSUY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:24:27 -0400
Date: Wed, 19 Apr 2006 21:24:21 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060419202421.GA24318@srcf.ucam.org>
References: <20060419195356.GA24122@srcf.ucam.org> <20060419200447.GA2459@isilmar.linta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060419200447.GA2459@isilmar.linta.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2006 at 10:04:47PM +0200, Dominik Brodowski wrote:
> On Wed, Apr 19, 2006 at 08:53:58PM +0100, Matthew Garrett wrote:
> > +++ a/include/linux/input.h	2006-04-19 20:49:18 +0100
> > @@ -344,6 +344,7 @@
> >  #define KEY_FORWARDMAIL		233
> >  #define KEY_SAVE		234
> >  #define KEY_DOCUMENTS		235
> > +#define KEY_LID			237
> 
> What about 236?

I sent a patch last month that uses 236 for KEY_BATTERY, so decided not 
to conflict with it.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
