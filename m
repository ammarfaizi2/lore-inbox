Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267709AbUJGSsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267709AbUJGSsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267537AbUJGSqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:46:39 -0400
Received: from ida.rowland.org ([192.131.102.52]:18180 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S267748AbUJGSqG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 14:46:06 -0400
Date: Thu, 7 Oct 2004 14:46:05 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: Power parents
Message-ID: <Pine.LNX.4.44L0.0410071444220.650-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben:

Pavel Machek suggested you were a good person to ask this question.

I see that the power tree agrees pretty much with the device tree, but
there is the possibility of having a different parent pointer.  However
the device_pm_set_parent() routine isn't called anywhere in the kernel.  
Does that mean it can be eliminated, making the two trees identical?

Alan Stern

