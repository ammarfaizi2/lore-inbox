Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269206AbUJKTxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269206AbUJKTxK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 15:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269207AbUJKTxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 15:53:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24528 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269206AbUJKTxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 15:53:06 -0400
Date: Mon, 11 Oct 2004 20:53:03 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Meelis Roos <mroos@linux.ee>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: LVM snapshot creation hang
Message-ID: <20041011195303.GA6408@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Meelis Roos <mroos@linux.ee>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <Pine.GSO.4.44.0410051312370.16512-100000@math.ut.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0410051312370.16512-100000@math.ut.ee>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 01:26:52PM +0300, Meelis Roos wrote:
> snapshot creation hangs the process (lvcreate):
> lvcreate --snapshot --name snap --size 100M /dev/vg/vol
 
If this is what I think it is, the fix needed is to LVM2 userspace 
code, and it's a quite a lot of work and still isn't scheduled yet 
I'm afraid:-(

Alasdair
-- 
agk@redhat.com
