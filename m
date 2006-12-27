Return-Path: <linux-kernel-owner+w=401wt.eu-S964776AbWL0Wac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWL0Wac (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 17:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWL0Wac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 17:30:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:44933 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964776AbWL0Wab (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 17:30:31 -0500
Subject: Re: [patch 2.6.12-rc2] PNP: export pnp_bus_type
From: Arjan van de Ven <arjan@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Adam Belay <abelay@novell.com>, ambx1@neo.rr.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200612271347.47114.david-b@pacbell.net>
References: <200612271347.47114.david-b@pacbell.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 27 Dec 2006 23:30:18 +0100
Message-Id: <1167258618.3281.4112.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-27 at 13:47 -0800, David Brownell wrote:
> The PNP framework doesn't export "pnp_bus_type", which is an unfortunate
> exception to the policy followed by pretty much every other bus.  I noticed
> this when I had to find a device in order to provide its platform_data.

can you please merge the export together with the driver? We already
have way too many unused exports, and the only sane way is to merge the
export with the user..... (and yes exports are not free, they take up
100 to 150 bytes of kernel size for example)



