Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262450AbUFBWDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbUFBWDO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 18:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264239AbUFBWDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 18:03:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38294 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262450AbUFBWDN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 18:03:13 -0400
Date: Wed, 2 Jun 2004 23:02:38 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3/5: Device-mapper: snapshots
Message-ID: <20040602220238.GB6627@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <22Gkd-1AX-17@gated-at.bofh.it> <m3r7sx6dip.fsf@averell.firstfloor.org> <20040602185924.GS6302@agk.surrey.redhat.com> <20040602192045.GA87771@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040602192045.GA87771@colin2.muc.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2004 at 09:20:45PM +0200, Andi Kleen wrote:
> So it's supposed to be crash safe? 

Depends on the type of crash: updates are sequenced and synced (in
co-ordinated batches) so it should cope with events like
freezing/stopping (but not necessarily memory corruption).

As Kevin indicated, we'll certainly be generating more documentation
in the near future.  [Some of this will be a by-product of the
forthcoming LVM2/device-mapper tutorial at LinuxTag.]

Alasdair
-- 
agk@redhat.com
