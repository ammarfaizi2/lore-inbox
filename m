Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264035AbTJ1QxM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264038AbTJ1QxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:53:12 -0500
Received: from fw.osdl.org ([65.172.181.6]:222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264035AbTJ1QxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:53:10 -0500
Date: Tue, 28 Oct 2003 08:53:06 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Kovacs Richard <krichard@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ACPI suspend doe snot work when X is running
In-Reply-To: <20031028102944.GA5230@login.elte.hu>
Message-ID: <Pine.LNX.4.33.0310280852350.7139-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I think it might have something to do with the modules
>
> agpgart,
> intel-agp,
> i830.

Please try unloading as many of those modules as you can before
suspending, and re-inserting them after you resume.


	Pat

