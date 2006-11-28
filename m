Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934424AbWK1CFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934424AbWK1CFo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 21:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934284AbWK1CFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 21:05:44 -0500
Received: from isilmar.linta.de ([213.239.214.66]:31132 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S934424AbWK1CFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 21:05:43 -0500
Date: Mon, 27 Nov 2006 21:05:41 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Linux kernel development <linux-kernel@vger.kernel.org>,
       PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
       David Hinds <dahinds@users.sourceforge.net>,
       Jaroslav Kysela <perex@suse.cz>,
       Bart Prescott <bart.prescott@elandigitalsystems.com>
Subject: Re: [PATCH] PCMCIA identification strings for Elan -- second attempt
Message-ID: <20061128020541.GD21472@isilmar.linta.de>
Mail-Followup-To: Tony Olech <tony.olech@elandigitalsystems.com>,
	Linux kernel development <linux-kernel@vger.kernel.org>,
	PCMCIA Maintainence <linux-pcmcia@lists.infradead.org>,
	David Hinds <dahinds@users.sourceforge.net>,
	Jaroslav Kysela <perex@suse.cz>,
	Bart Prescott <bart.prescott@elandigitalsystems.com>
References: <200611201306.kAKD6gRt008347@imap.elan.private>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611201306.kAKD6gRt008347@imap.elan.private>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 01:04:39PM +0000, Tony Olech wrote:
> patch against linux kernel 2.6.18 to add PCMCIA identification strings
> From: Tony Olech <tony.olech@elandigitalsystems.com>
> 
> In older versions of the linux kernel it was sufficient for the
> 16-bit PCMCIA card manufacturer to distribute or make available
> a text configuration file along with the physical cards. Such a
> file with an extension of ".conf" and placed in the /etc/pcmcia
> very easily enabled new hardware without rebuilding the kernel,
> however with the new scheme of things, having found no userland
> solution to the problem of new 16bit pcmcia card identification
> this patch enumerates Elan Digital Systems strings.
> 
> In addition, for the ID strings to result in the correct module
> being loaded, the too wide matching criterion of the PDaudioCF
> card needs to have the MANF_ID/CARD_ID numbers replaced by the
> more specific PROD_ID1 and PROD_ID2 strings. It is unfortunate
> that otherwise the pdaudiocf module is loaded whenever an ELAN
> pcmcia card is inserted, resulting in various random lockups

Applied to pcmcia-2.6, thanks.

	Dominik
