Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266210AbUAGQAV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUAGQAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:00:21 -0500
Received: from ida.rowland.org ([192.131.102.52]:15364 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S266210AbUAGQAS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:00:18 -0500
Date: Wed, 7 Jan 2004 11:00:16 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Greg KH <greg@kroah.com>, Patrick Mochel <mochel@osdl.org>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: "Miscellaneous" bus for the driver model?
Message-ID: <Pine.LNX.4.44L0.0401071054220.850-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would it make sense for the driver model core to add a "miscellaneous" or 
"other" bus, intended for devices or drivers that are one-of-a-kind or 
otherwise non-standard?  Kind of similar to the platform bus but meant 
for new things, not part of a legacy or other system/architecture-specific 
base?

Doing this would give people a place to register these things without 
forcing them to go to the trouble of making up their own special-purpose 
bus or class.  And without the extra code/data space a special-purpose 
driver-specific bus would require.

Alan Stern

