Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751703AbWEPIja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703AbWEPIja (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 04:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbWEPIja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 04:39:30 -0400
Received: from smtp-102-tuesday.noc.nerim.net ([62.4.17.102]:38405 "EHLO
	mallaury.nerim.net") by vger.kernel.org with ESMTP id S1751700AbWEPIja
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 04:39:30 -0400
Date: Tue, 16 May 2006 10:39:30 +0200
From: Jean Delvare <khali@linux-fr.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Greg KH <gregkh@suse.de>, Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 2.6.17-rc4-mm1
Message-Id: <20060516103930.0c0d5d33.khali@linux-fr.org>
In-Reply-To: <6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
References: <20060515005637.00b54560.akpm@osdl.org>
	<6bffcb0e0605151137v25496700k39b15a40fa02a375@mail.gmail.com>
	<20060515115302.5abe7e7e.akpm@osdl.org>
	<6bffcb0e0605151210x21eb0d24g96366ce9c121c26c@mail.gmail.com>
	<20060515122613.32661c02.akpm@osdl.org>
	<6bffcb0e0605151317u51bbf67ey124b808fad920d36@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I'd assume that Kumar's i2c-add-support-for-virtual-i2c-adapters.patch is
> > the culprit.
> 
> Unfortunately it's not this patch.
> I'll check all Kumar's patches.

There are no differences in i2c patches between 2.6.17-rc3-mm1 and
2.6.17-rc4-mm1. As you said the bug is new in 2.6.17-rc4-mm1, this
suggests that the bug is not in the i2c patches. Could be that these
patches need to be updated to reflect a recent change in another tree
though.

I'll try to reproduce the bug here.

-- 
Jean Delvare
