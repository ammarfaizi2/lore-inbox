Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262344AbTLKWQM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 17:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263447AbTLKWQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 17:16:12 -0500
Received: from smtp06.iddeo.es ([62.81.186.16]:58053 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S262344AbTLKWQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 17:16:08 -0500
Date: Thu, 11 Dec 2003 23:16:04 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: udev for dummies
Message-ID: <20031211221604.GA2939@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

I am starting to use 2.6, and I really would like to use udev.
But I can't find a doc about how to move from taditional heavily
populated /dev to new method.

Any pointer ?

I have installed udev and hotplug utils, and have hotplug enabled in
kernel.
As I undestand it, I should do now something like
- run udev for the first time, so it populates /udev
- check that basic dev files are there
- move /dev to /dev.old, and ln -s /udev /dev (or real-move it and
  change udev.conf to write directly on /dev)

Or just create and empty /dev, and let hotplug call hotplug scripts
on boot which in turn call udev. Is this correct ? Will hotplug call
udev for the built-in drivers ?
Could it also work without hotplugging, ie, can I use udev to just
create a minimal /dev for my system ?

After installing udev, I run /sbin/udev and nothing appears on
/udev.

What am I missing / misunderstanding ?

TIA

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.0-test11-jam1 (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-4mdk))
