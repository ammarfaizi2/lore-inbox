Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264277AbTFPUmH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264279AbTFPUmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:42:07 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264277AbTFPUlv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:41:51 -0400
Date: Mon, 16 Jun 2003 13:51:24 -0700 (PDT)
Message-Id: <20030616.135124.71580008.davem@redhat.com>
To: ak@suse.de
Cc: janiceg@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       stekloff@us.ibm.com, girouard@us.ibm.com, lkessler@us.ibm.com,
       kenistonj@us.ibm.com, jgarzik@pobox.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030616205342.GH30400@wotan.suse.de>
References: <3EEE28DE.6040808@us.ibm.com>
	<20030616.133841.35533284.davem@redhat.com>
	<20030616205342.GH30400@wotan.suse.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andi Kleen <ak@suse.de>
   Date: Mon, 16 Jun 2003 22:53:42 +0200
   
   Why? It will make supporting netconsole easier which has to be careful
   to never recurse in the network driver.

printk can check this
