Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266268AbUANA2X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:28:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266280AbUANA2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:28:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:19919 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266268AbUANA2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:28:09 -0500
Date: Tue, 13 Jan 2004 16:21:12 -0800
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: jt@hpl.hp.com, jt@bougret.hpl.hp.com, jgarzik@pobox.com,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.X] SIOCSIFNAME wilcard suppor & name validation
Message-Id: <20040113162112.509edb71.davem@redhat.com>
In-Reply-To: <20040113142204.0b41403b.shemminger@osdl.org>
References: <20040112234332.GA1785@bougret.hpl.hp.com>
	<20040113142204.0b41403b.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 14:22:04 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Here is an enhanced version of the previous patch.
> It adds both the wildcard support that Jean did, and validation of network
> device names.
> 
> It doesn't check the error return from class_device_rename because
> that will not fail unless object or name are null.

This is really cool, nice work guys.

Patch applied, thanks.
