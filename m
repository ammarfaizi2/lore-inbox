Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbTKIA3I (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 19:29:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTKIA3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 19:29:08 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24076
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262094AbTKIA3G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 19:29:06 -0500
Subject: Re: sysfs vs. procfs, devfs vs. ufs ?
From: Robert Love <rml@tech9.net>
To: Nico Schottelius <nico-mutt@schottelius.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20031107032856.GS25124@schottelius.org>
References: <20031107032856.GS25124@schottelius.org>
Content-Type: text/plain
Message-Id: <1068337724.27320.217.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sat, 08 Nov 2003 19:28:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-06 at 22:28, Nico Schottelius wrote:

> what is the intention of sysfs?
> is it a replacement/addition to procfs?

sysfs is a filesystem used to export the device model (a tree of data
structures representing the devices in a system) to user-space in a
clean and efficient way.

procfs is a more generic (and less elegant) filesystem for exporting
anything to user-space.

sysfs only replaces procfs in so far as relevant interfaces, such as
those related to hardware.  process information should remain in procfs.

/proc is not going anywhere.

	Robert Love


