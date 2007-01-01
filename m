Return-Path: <linux-kernel-owner+w=401wt.eu-S932796AbXAAUPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbXAAUPF (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 15:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932813AbXAAUPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 15:15:04 -0500
Received: from gate.crashing.org ([63.228.1.57]:36626 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932796AbXAAUPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 15:15:03 -0500
Subject: Re: kref refcnt and false positives
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       Greg Kroah-Hartman <gregkh@suse.de>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
In-Reply-To: <1167578178.22068.326.camel@pmac.infradead.org>
References: <200612210901.kBL91MwR027509@hera.kernel.org>
	 <1167578178.22068.326.camel@pmac.infradead.org>
Content-Type: text/plain
Date: Tue, 02 Jan 2007 07:13:22 +1100
Message-Id: <1167682402.23340.134.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This makes my Maple board very unhappy -- it triggers a WARN_ON() in
> kref_get() lots of times...

Maybe the refounting in prom.c is broken ? I'll have a look.

Ben.

