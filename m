Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262096AbULCI7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262096AbULCI7x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 03:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbULCI7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 03:59:53 -0500
Received: from prufz.de ([217.160.140.225]:6551 "EHLO mail.zuto.de")
	by vger.kernel.org with ESMTP id S262096AbULCI7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 03:59:48 -0500
Date: Fri, 3 Dec 2004 09:09:39 +0100
From: Peter Bartosch <peter@bartosch.net>
To: linux-kernel@vger.kernel.org
Subject: create_proc_entry within probe function (USB)
Message-ID: <20041203080939.GA23984@bartosch.net>
Reply-To: peter@bartosch.net
Mail-Followup-To: peter@bartosch.net, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,


I'm developing a USB drive ant try to create a proc-entry within my
probe-function. Neither create_proc_read_entry nor create_proc_entry do
work completely:

If i disconnect/connect the USB-Hardware the proc-entries will be
created. But: if i only reload the module the probe-function is
called but the proc-entries won't be created!?


yours,

Peter

