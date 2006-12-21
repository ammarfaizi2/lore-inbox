Return-Path: <linux-kernel-owner+w=401wt.eu-S1422852AbWLUI1Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422852AbWLUI1Z (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 03:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422855AbWLUI1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 03:27:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37373 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422852AbWLUI1Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 03:27:24 -0500
Subject: Re: Changes to sysfs PM layer break userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: David Brownell <david-b@pacbell.net>,
       Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org,
       gregkh@suse.de
In-Reply-To: <20061220210214.f9b94889.akpm@osdl.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <200612191929.14524.david-b@pacbell.net>
	 <20061220195117.4d12dee7.akpm@osdl.org>
	 <200612202056.28177.david-b@pacbell.net>
	 <20061220210214.f9b94889.akpm@osdl.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 21 Dec 2006 09:27:17 +0100
Message-Id: <1166689637.3365.1475.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > 
> > > What we should do is to revert 047bda36150d11422b2c7bacca1df324c909c0b3 and
> > 
> > Bad answer
> 
> Is better than breaking stuff.

.. stuff that made assumptions about something and did stuff it probably
shouldn't have been doing for the intent it had ;)

the semantics of this thing were clear as mud, and actually
disfunctional.... (and the user of it that "broke" actually wanted
something else, but didn't because a few drivers didn't implement it
quite the right way)
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

