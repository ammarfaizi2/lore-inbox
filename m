Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbUDBW6t (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Apr 2004 17:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261258AbUDBW6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Apr 2004 17:58:49 -0500
Received: from digitalimplant.org ([64.62.235.95]:53906 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S261263AbUDBW6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Apr 2004 17:58:47 -0500
Date: Fri, 2 Apr 2004 14:58:37 -0800 (PST)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Todd Poynor <tpoynor@mvista.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Device suspend/resume fixes
In-Reply-To: <20040402222838.GB2423@dhcp193.mvista.com>
Message-ID: <Pine.LNX.4.50.0404021458150.20130-100000@monsoon.he.net>
References: <20040402222838.GB2423@dhcp193.mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> (3) Flush signals between resume handlers in case a resume function
> causes, for example, an ECHILD from modprobe or hotplug, so
> interruptible APIs for the next handler aren't affected.

Are there really cases in which you see this as an issue?


	Pat
