Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbUFJWS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbUFJWS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 18:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263134AbUFJWS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 18:18:56 -0400
Received: from main.gmane.org ([80.91.224.249]:3993 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263126AbUFJWSz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 18:18:55 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Lars <terraformers@gmx.net>
Subject: Re: 2.6.7-rc3: nforce2, no C1 disconnect fixup applied
Date: Fri, 11 Jun 2004 00:19:04 +0200
Message-ID: <caamob$gb0$1@sea.gmane.org>
References: <ca9jj9$dr$1@sea.gmane.org> <200406101558.54240.bzolnier@elka.pw.edu.pl> <caak85$9vg$1@sea.gmane.org> <200406102356.07920.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9e7e173.dip.t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just learned that
setpci -H1 -s 0:0.0 6C.L=0x9F01FF01
enables C1 *and* the 80ns stability fix.

looks like i have to stick with my ugly little workaround for a while


best,
lars


> Order should be reversed.
> 
> It can be perfectly handled in user-space as you've just showed. :-)
> There is no need to add complexity to the kernel.


