Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVDZOOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVDZOOl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 10:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVDZOOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 10:14:41 -0400
Received: from mail.shareable.org ([81.29.64.88]:6057 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S261539AbVDZOOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 10:14:34 -0400
Date: Tue, 26 Apr 2005 15:14:26 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ville Herva <v@iki.fi>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: filesystem transactions API
Message-ID: <20050426141426.GC10833@mail.shareable.org>
References: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk> <OF32F95BBA.F38B2D1F-ON88256FEE.006FE841-88256FEE.00742E46@us.ibm.com> <20050426134629.GU16169@viasys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050426134629.GU16169@viasys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> Apparently, Windows Longhorn will include something called "transactional
> NTFS". It's explained pretty well in
> 
>    http://blogs.msdn.com/because_we_can/
> 
> Basically, a process can create a fs transaction, and all fs changes made
> between start of the transaction and commit are atomical - meaning nothing
> is visible until commit, and if commit fails, everything is rolled back.
> 
> Sound useful... Although there are no service pack installs that could fail
> in Linux, the same thing could be useful in rpm, yum, almost anything. 
> 
> What do you think?

I think I've wanted something like that for _years_ in unix.

It's an old, old idea, and I've often wondered why we haven't implemented it.

-- Jamie
