Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161118AbWAHBI3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161118AbWAHBI3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 20:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161119AbWAHBI3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 20:08:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:5597 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161118AbWAHBI2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 20:08:28 -0500
Date: Sat, 7 Jan 2006 17:08:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Drop vmlinux dependency from "make install"
In-Reply-To: <43C06420.1080300@zytor.com>
Message-ID: <Pine.LNX.4.64.0601071707160.3169@g5.osdl.org>
References: <43C06420.1080300@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I think you should make the error messages a bit more informative. Like 
saying

	You need to build the tree before you can install it

instead of saying "missing file: xyzzy".

		Linus

