Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVHLRjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVHLRjY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 13:39:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbVHLRjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 13:39:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:65496 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750759AbVHLRjX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 13:39:23 -0400
Date: Fri, 12 Aug 2005 10:38:32 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: 7eggert@gmx.de
Cc: harvested.in.lkml@7eggert.dyndns.org, vonbrand@inf.utfsm.cl,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Problem with usb-storage and /dev/sd?
Message-Id: <20050812103832.28ff17a0.zaitcev@redhat.com>
In-Reply-To: <E1E3X6P-0000cN-BB@be1.lrz>
References: <4pzyn-10f-33@gated-at.bofh.it>
	<4AubX-4w6-9@gated-at.bofh.it>
	<E1E3X6P-0000cN-BB@be1.lrz>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Aug 2005 12:49:28 +0200, Bodo Eggert <harvested.in.lkml@7eggert.dyndns.org> wrote:

> Which label will a random USB stick have?

GUID, I presume. Ask Andries Brouwer, he hacked on that, IIRC.
Actually msdos has on-disk format for user-settable labels in
the way analoguous to tune2fs -L label. I just do not know if
our implementation recognizes them.

-- Pete
