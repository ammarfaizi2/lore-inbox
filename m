Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264156AbTEaGWG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 02:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264157AbTEaGWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 02:22:05 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15029 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264156AbTEaGWF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 02:22:05 -0400
Date: Fri, 30 May 2003 23:33:53 -0700 (PDT)
Message-Id: <20030530.233353.28798744.davem@redhat.com>
To: wli@holomorphy.com
Cc: alexander.riesen@synopsys.COM, scrosby@cs.rice.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Algoritmic Complexity Attacks and 2.4.20 the dcache code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030531063040.GI8978@holomorphy.com>
References: <20030530085901.GB11885@Synopsys.COM>
	<20030530.020040.52897577.davem@redhat.com>
	<20030531063040.GI8978@holomorphy.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Lee Irwin III <wli@holomorphy.com>
   Date: Fri, 30 May 2003 23:30:40 -0700
   
   If the strength reduction situation changes to being properly handled
   by gcc for most/all 64-bit arches, include/linux/hash.h can lose a #ifdef.

It's not a strength reduction issue, it's about not setting the
multiply cost properly in the machine description.
