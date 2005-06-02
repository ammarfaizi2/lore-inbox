Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261433AbVFBWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261433AbVFBWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbVFBWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 18:18:56 -0400
Received: from gate.crashing.org ([63.228.1.57]:64721 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261433AbVFBWSy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:18:54 -0400
Subject: Re: [RFC] Add some hooks to generic suspend code
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Seyfried <seife@suse.de>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <429F321D.9000009@suse.de>
References: <1117524577.5826.35.camel@gaston>
	 <20050531101344.GB9614@elf.ucw.cz>	<1117550660.5826.42.camel@gaston>
	 <20050531212556.GA14968@elf.ucw.cz>  <429F321D.9000009@suse.de>
Content-Type: text/plain
Date: Fri, 03 Jun 2005 08:18:00 +1000
Message-Id: <1117750680.31082.81.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-06-02 at 18:21 +0200, Stefan Seyfried wrote:

> >> Sure, ideally. However, existing X knows how to deal with APM events,
> >> and thus APM emulation is an important thing to get something that
> >> works. Pne thing I should do is consolidate PPC APM emu with ARM one as
> >> I think Russell improve my stuff significantly.
> > 
> > Perhaps we need apm emulation on i386, too?
> 
> No. This is too ugly for words IMO. If we have one good mechanism of
> notifying userland, X can use this mechanism. Let's kill APM, not keep
> it alive.

Euh... maybe but I still think we need to keep this userland interface
alive for a little while. At least ARM and PPC have existing stuff that
rely on it.

Ben.


