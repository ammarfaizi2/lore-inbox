Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030945AbWKUN2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030945AbWKUN2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 08:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030947AbWKUN2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 08:28:10 -0500
Received: from isilmar.linta.de ([213.239.214.66]:8426 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1030945AbWKUN2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 08:28:09 -0500
Date: Tue, 21 Nov 2006 08:28:07 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for Elan -- second attempt
Message-ID: <20061121132807.GB23235@isilmar.linta.de>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201306.kAKD6gRt008347@imap.elan.private> <20061120174924.GC18660@isilmar.linta.de> <1164099203.30853.51.camel@n04-143.elan.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164099203.30853.51.camel@n04-143.elan.private>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 08:53:22AM +0000, Tony Olech wrote:
> YES is does indeed have 4 serial channels.

Four serial channels might be handled by two device functions... and it's
the number of device function which decides whether it is a "MFC" device or
not. And if it indeed has four sub-devices, the PCMCIA core needs to be
improved -- therefore, could you send me a CIS dump for this device, please?

Thanks,
	Dominik
