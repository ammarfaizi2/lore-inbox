Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbVIKTfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVIKTfj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 15:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750820AbVIKTfj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 15:35:39 -0400
Received: from mx1.rowland.org ([192.131.102.7]:28690 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1750819AbVIKTfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 15:35:38 -0400
Date: Sun, 11 Sep 2005 15:35:37 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Elimination of klists
Message-ID: <Pine.LNX.4.44L0.0509111531470.25522-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James:

I noticed that you recently posted some updates to the klist code, 
although I haven't looked to see how you are using the klists.

What do you think about eliminating klists entirely, and instead using 
regular lists protected by either a mutex or an rwsem?  It would remove a 
good deal of overhead, and I think it wouldn't be hard to convert the 
driver core.  Would this be feasible for the things you're doing?

Alan Stern

