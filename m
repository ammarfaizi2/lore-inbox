Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbULUMvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbULUMvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 07:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbULUMvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 07:51:32 -0500
Received: from dspnet.fr.eu.org ([62.73.5.179]:12307 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S261749AbULUMvR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 07:51:17 -0500
Date: Tue, 21 Dec 2004 13:51:05 +0100
From: Olivier Galibert <galibert@pobox.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: ioctl assignment strategy?
Message-ID: <20041221125105.GA61745@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	LKML <linux-kernel@vger.kernel.org>
References: <1103067067.2826.92.camel@chatsworth.hootons.org> <20041215004620.GA15850@kroah.com> <41C04FFA.6010407@nortelnetworks.com> <20041217234854.GA24506@kroah.com> <41C70DF2.80101@nortelnetworks.com> <41C756CA.5080504@xs4all.nl> <1103589129.32548.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103589129.32548.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2004 at 12:32:11AM +0000, Alan Cox wrote:
> Ioctls do have some serious problems that make them nice to avoid
> [...]

5. ioctls don't have a reliable size information in the call, making
them hard to forward over a network in a generic way, or even pass to
another userspace process.

  OG.

