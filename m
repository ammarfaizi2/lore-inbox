Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264893AbUEVHlN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264893AbUEVHlN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 03:41:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEVHlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 03:41:13 -0400
Received: from colin2.muc.de ([193.149.48.15]:60166 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264893AbUEVHlM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 03:41:12 -0400
Date: 22 May 2004 09:41:11 +0200
Date: Sat, 22 May 2004 09:41:11 +0200
From: Andi Kleen <ak@muc.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: brettspamacct@fastclick.com, Andi Kleen <ak@muc.de>,
       linux-kernel@vger.kernel.org
Subject: Re: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Message-ID: <20040522074111.GA10462@colin2.muc.de>
References: <1Y6yr-eM-11@gated-at.bofh.it> <1Yn67-50q-7@gated-at.bofh.it> <m3lljld1v1.fsf@averell.firstfloor.org> <93090000.1085171530@flay> <40AE93E0.7060308@fastclick.com> <1720000.1085206414@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1720000.1085206414@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> ># numactl --show
> > No NUMA support available on this system.
> > 
> > despite using kernel 2.6.6.

You need 2.6.6-mm*. numa api hasn't been merged to mainline yet.

-Andi
