Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTFPWDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTFPWDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:03:37 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57808 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264394AbTFPWDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:03:34 -0400
Date: Mon, 16 Jun 2003 15:13:08 -0700 (PDT)
Message-Id: <20030616.151308.55864910.davem@redhat.com>
To: niv@us.ibm.com
Cc: janiceg@us.ibm.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       stekloff@us.ibm.com, girouard@us.ibm.com, lkessler@us.ibm.com,
       kenistonj@us.ibm.com, jgarzik@pobox.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3EEE40F1.4030107@us.ibm.com>
References: <3EEE28DE.6040808@us.ibm.com>
	<3EEE40F1.4030107@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Nivedita Singhvi <niv@us.ibm.com>
   Date: Mon, 16 Jun 2003 15:13:05 -0700
   
   I'd certainly like to see messages from the driver when the
   card enters/leaves promiscuous mode,

egrep "promiscuous mode" net/core/dev.c | grep printk
