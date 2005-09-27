Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964782AbVI0Ci1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964782AbVI0Ci1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 22:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbVI0Ci0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 22:38:26 -0400
Received: from mx1.rowland.org ([192.131.102.7]:1553 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S964782AbVI0Ci0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 22:38:26 -0400
Date: Mon, 26 Sep 2005 22:38:21 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Readahead
Message-ID: <Pine.LNX.4.44L0.0509262234500.32418-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can somebody please tell me where the code is that performs optimistic
readahead when a process does sequential reads on a block device?

And can someone explain why those readahead calls are allowed to extend 
beyond the end of the device?

Alan Stern

