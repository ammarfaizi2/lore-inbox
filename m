Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWIIDLG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWIIDLG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 23:11:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbWIIDLG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 23:11:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:63617 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932098AbWIIDLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 23:11:04 -0400
Date: Fri, 8 Sep 2006 20:10:20 -0700
From: Greg KH <gregkh@suse.de>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, Adrian Bunk <bunk@stusta.de>
Subject: Re: Fwd: [-stable patch] pci_ids.h: add some VIA IDE identifiers
Message-ID: <20060909031020.GA17712@suse.de>
References: <20060909001925.GB1032@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060909001925.GB1032@redhat.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 08:19:25PM -0400, Dave Jones wrote:
> This never made it into 2.6.17.12
> Without it, this happens..
> 
> drivers/ide/pci/via82cxxx.c:85: error: 'PCI_DEVICE_ID_VIA_8237A' undeclared here (not in a function)

Doh!  Sorry about that, I forgot to do a run with 'make allmodconfig'
this time around, and it shows :(

.13 will be out shortly...

thanks,

greg k-h
