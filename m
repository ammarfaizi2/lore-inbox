Return-Path: <linux-kernel-owner+w=401wt.eu-S932821AbWL1KFc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbWL1KFc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 05:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932865AbWL1KFc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 05:05:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42043 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932821AbWL1KFb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 05:05:31 -0500
Subject: Re: [patch 2.6.12-rc2] PNP: export pnp_bus_type
From: Arjan van de Ven <arjan@infradead.org>
To: David Brownell <david-b@pacbell.net>
Cc: Adam Belay <abelay@novell.com>, ambx1@neo.rr.com,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200612271559.02077.david-b@pacbell.net>
References: <200612271347.47114.david-b@pacbell.net>
	 <1167258618.3281.4112.camel@laptopd505.fenrus.org>
	 <200612271559.02077.david-b@pacbell.net>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 28 Dec 2006 11:05:02 +0100
Message-Id: <1167300302.3281.4181.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hmm, then maybe it'd be worth updating that patch I just sent so that
> the only change is to switch #includes for the extern decl ... i.e. to
> "export" it only to other statically linked kernel code, rather than to
> modules.  I'll do that.
> 
> My own question about that EXPORT_SYMBOL was whether it instead be
> an EXPORT_SYMBOL_GPL, but if either one costs bytes ... I'm happy to
> avoid that cost!

no export if it's not *really* need is obviously superior to either of
those so yes I like the patch you're talking about already without even
having seen it ;)


>   
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

