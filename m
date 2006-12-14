Return-Path: <linux-kernel-owner+w=401wt.eu-S932832AbWLNPwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932832AbWLNPwK (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932831AbWLNPwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:52:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:48502 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932828AbWLNPwI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:52:08 -0500
Subject: Re: [PATCH] Clarify i386/Kconfig explanation of the HIGHMEM config
	options
From: Arjan van de Ven <arjan@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Franck Pommereau <pommereau@univ-paris12.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <20061214151745.GC9079@thunk.org>
References: <458118BB.5050308@univ-paris12.fr>
	 <1166090244.27217.978.camel@laptopd505.fenrus.org>
	 <45813E67.80709@univ-paris12.fr>
	 <1166098747.27217.1018.camel@laptopd505.fenrus.org>
	 <20061214151745.GC9079@thunk.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 14 Dec 2006 16:52:05 +0100
Message-Id: <1166111525.27217.1068.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-12-14 at 10:17 -0500, Theodore Tso wrote:
> > > I'd be happy to know how to enable it.
> >
> > CONFIG_HIGHMEM64G=y
> 
> This is not at all obvious from arch/i386/Kconfig.  Maybe we should
> fix this?

looks better; maybe add how to look for "pae" and "nx" in
the /proc/cpuinfo flags line ?

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

