Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266008AbUAVIZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUAVIZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:25:18 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266008AbUAVIYj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:24:39 -0500
Date: Thu, 22 Jan 2004 08:24:38 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Nigel Cunningham <ncunningham@users.sourceforge.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Export console functions for use by Software Suspend nice display
Message-ID: <20040122082438.GV21151@parcelfarce.linux.theplanet.co.uk>
References: <1074757083.1943.37.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1074757083.1943.37.camel@laptop-linux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 09:12:00PM +1300, Nigel Cunningham wrote:
> Hi.
> 
> Here's a second patch; this exports gotoxy, reset_terminal, hide_cursor,
> getconsxy and putconsxy for use in Software Suspend's nice display.

Why don't you open /dev/console on rootfs and use write(2)?
