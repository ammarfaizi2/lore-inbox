Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbWHOTs7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbWHOTs7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932779AbWHOTs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:48:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:46261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932518AbWHOTs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:48:58 -0400
Date: Tue, 15 Aug 2006 15:48:57 -0400
From: Bill Nottingham <notting@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: bonding: cannot remove certain named devices
Message-ID: <20060815194856.GA3869@nostromo.devel.redhat.com>
Mail-Followup-To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rc4+.

Trivial example:

# modprobe bonding (creates bond0)
# ip link set bond0 name "a b"
# echo "-a b" > /sys/class/net/bonding_masters 
bonding: unable to delete non-existent bond a
bash: echo: write error: No such device

Bill
