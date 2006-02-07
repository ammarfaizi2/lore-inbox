Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbWBGBx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWBGBx6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:53:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbWBGBx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:53:58 -0500
Received: from chiark.greenend.org.uk ([193.201.200.170]:52365 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S932157AbWBGBx5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:53:57 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: safemode@comcast.net, alan@lxorguk.ukuu.org.uk, harald.dunkel@t-online.de,
       linux-kernel@vger.kernel.org, rdunlap@xenotime.net,
       Ed Sweetman <safemode@comcast.net>
Subject: Re: 2.6.16-rc1-mm2 pata driver confusion + tsc sync issues
In-Reply-To: <20060206173520.43412664.akpm@osdl.org>
References: <Pine.LNX.4.58.0601250846210.29859@shark.he.net> <43E3D103.70505@comcast.net> <Pine.LNX.4.58.0602060836520.1309@shark.he.net> <43E7A4C0.4020209@t-online.de> <1139255800.10437.51.camel@localhost.localdomain> <43E805D4.5010602@comcast.net> <43E7F73E.2070004@comcast.net> <43E7F73E.2070004@comcast.net> <20060206173520.43412664.akpm@osdl.org>
Date: Tue, 7 Feb 2006 01:53:54 +0000
Message-Id: <E1F6I3G-0003fw-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> That's bad.

Given that libata goes through the scsi layer at the moment, shifting
from the traditional PATA drivers to the libata ones is going to result
in a shift from hdfoo to sdbar. We're not really looking forward to this
from the distribution point of view, though I think the same thing
happened in the past when shifting from the ancient SATA drivers to the
libata ones.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
