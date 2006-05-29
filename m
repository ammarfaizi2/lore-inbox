Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWE2GTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWE2GTs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 02:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWE2GTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 02:19:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25276 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751233AbWE2GTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 02:19:47 -0400
Subject: Re: Should we make dmi_check_system case insensitive?
From: Arjan van de Ven <arjan@infradead.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: "LKML," <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>, Andi Kleen <ak@muc.de>,
       Andrey Panin <pazke@orbita1.ru>
In-Reply-To: <200605290131.42292.dtor_core@ameritech.net>
References: <200605290131.42292.dtor_core@ameritech.net>
Content-Type: text/plain
Date: Mon, 29 May 2006 08:19:08 +0200
Message-Id: <1148883548.3291.50.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-05-29 at 01:31 -0400, Dmitry Torokhov wrote:
> Hi,
> 
> I have a request to add entry for "LifeBook B Series" to lifebook driver to
> accomodate lifebook B2545, however we already have entry for "LIFEBOOK B
> Series" (used by some other model) which is not working. Would anyone
> be opposed making dmi_check_system() ignore string case? 

yes I would.
There are very legit reasons to be able to separate both machines, for
other things they may well be not the same after all. Once you go case
insensitive you can't separate at all anymore; I rather have an
occasional "dupe" in the table than a really huge mess of things you
can't keep separate anymore....

