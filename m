Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264403AbTFPWqK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 18:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264407AbTFPWqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 18:46:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23505 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264403AbTFPWqE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 18:46:04 -0400
Date: Mon, 16 Jun 2003 15:55:33 -0700 (PDT)
Message-Id: <20030616.155533.63022973.davem@redhat.com>
To: girouard@us.ibm.com
Cc: stekloff@us.ibm.com, janiceg@us.ibm.com, jgarzik@pobox.com,
       kenistonj@us.ibm.com, lkessler@us.ibm.com, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, niv@us.ibm.com
Subject: Re: patch for common networking error messages
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <OFC2446DB8.6D4DA3ED-ON85256D47.007C79EE@us.ibm.com>
References: <OFC2446DB8.6D4DA3ED-ON85256D47.007C79EE@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Janice Girouard <girouard@us.ibm.com>
   Date: Mon, 16 Jun 2003 17:50:08 -0500
   
   One possible suggestion would be to submit more than one stdmsgs.h
   files.  One a legacy file, and one that is more consistent from
   message to message.. shooting for a gradual migration.

Let me know when you're back on planet earth ok?

Standardizing strings is an absolutely FRUITLESS exercise.

If you want events, standardize events and push them over
a queueing based communications channel to userspace, namely
using netlink sockets.
