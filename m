Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271158AbTHHCmr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 22:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271161AbTHHCmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 22:42:47 -0400
Received: from cmu-24-35-14-252.mivlmd.cablespeed.com ([24.35.14.252]:39821
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S271158AbTHHCmq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 22:42:46 -0400
Date: Thu, 7 Aug 2003 22:41:57 -0500 (CDT)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: akpm@osdl.org, <zwane@arm.linux.org.uk>
Subject: [Bug 973] Presario kernel panic with 2.6.0
Message-ID: <Pine.LNX.4.44.0308072232370.13175-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After a short interruption in testing caused by friends visiting from 
Maine I have resumed chasing a panic which I only see on my laptop.

Please see bugzilla 973 for the gory details of hardware, panic messages, 
config, etc.  

At the request of Zwane, to whom this bug is assigned, I have restested 
with 2.6.0-test2 as well as with the mm5 patch from Andrew Morton.  I am 
still seeing the same panic.

I believe Zwane thinks this is related to Synaptics code, but I am 
unconvinced.  I tried the akpm patchset both with and without Synaptics 
support and it made no difference.  

I apologize for the oops message going to bugzilla being incomplete.  The 
laptop has USB, but no "regular" serial ports, and I have yet to procure a 
USB-to-9pin serial converter.  

Thanks in advnace for everyone's attention.  I will update the bugzilla 
page tomorrow.


