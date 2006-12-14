Return-Path: <linux-kernel-owner+w=401wt.eu-S932845AbWLNQGc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbWLNQGc (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:06:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbWLNQGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:06:32 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53651 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932845AbWLNQGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:06:31 -0500
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config
	options
From: Arjan van de Ven <arjan@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: thunder7@xs4all.nl, Franck Pommereau <pommereau@univ-paris12.fr>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061214153754.GD9079@thunk.org>
References: <458118BB.5050308@univ-paris12.fr>
	 <1166090244.27217.978.camel@laptopd505.fenrus.org>
	 <45813E67.80709@univ-paris12.fr>
	 <1166098747.27217.1018.camel@laptopd505.fenrus.org>
	 <20061214151745.GC9079@thunk.org> <20061214152721.GA5652@amd64.of.nowhere>
	 <20061214153754.GD9079@thunk.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 14 Dec 2006 17:06:28 +0100
Message-Id: <1166112388.27217.1074.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:37 -0500, Theodore Tso wrote:
> > +	  1 Gigabyte or more total physical RAM, answer "off" here.
> > 
> 
> I don't think your proposed wording (1 gigabyte or more) versus (more
> than 1 gigabyte) doesn't really change the sense of this.
> 
> If we want to be even more explicit about this, then if the CPU level
> selected by the user is greater than Pentium-M (or whatever is was the
> oldest CPU that didn't have NX support --- Arjan?) 

later pentium M's do support PAE (for NX). Only the very first ones did
not. Celerons might not either.. but PPro and later generally have
pae...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

