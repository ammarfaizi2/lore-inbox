Return-Path: <linux-kernel-owner+w=401wt.eu-S1751615AbWLVRnc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751615AbWLVRnc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 12:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbWLVRnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 12:43:32 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:51591 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbWLVRnb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 12:43:31 -0500
X-Originating-Ip: 24.163.66.209
Date: Fri, 22 Dec 2006 12:36:41 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Randy Dunlap <rdunlap@xenotime.net>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Rename FIELD_SIZEOF to MEMBER_SIZE and use in source
 tree.
In-Reply-To: <20061222092752.76af799b.rdunlap@xenotime.net>
Message-ID: <Pine.LNX.4.64.0612221236360.7893@localhost.localdomain>
References: <Pine.LNX.4.64.0612221013290.5467@localhost.localdomain>
 <20061222092752.76af799b.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-12.808, required 5, ALL_TRUSTED -1.80, BAYES_00 -15.00,
	RCVD_IN_NJABL_DUL 1.95, RCVD_IN_SORBS_DUL 2.05)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Dec 2006, Randy Dunlap wrote:

> On Fri, 22 Dec 2006 10:34:09 -0500 (EST) Robert P. J. Day wrote:
>
> >
> >   Rename the macro FIELD_SIZEOF() in include/linux/kernel.h to
> > MEMBER_SIZE(), and make a number of replacements in the source tree
> > where that macro simplified the code.
>
> Hi,
>
> Your CodingStyle ch. 17 additions also need to be updated
> if/when they are merged (since they refer to FIELD_SIZEOF()).
> Did Andrew add that to -mm?  I don't recall.

yes, that went in already.  re-reading christopher's recent posting,
he seems fairly convinced that that macro should be called either
SIZEOF_FIELD or FIELD_SIZE.  i'm happy with either choice, so someone
else can make the decision and i'll go with it.

rday
