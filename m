Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263771AbUAOWzm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUAOWzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:55:41 -0500
Received: from rth.ninka.net ([216.101.162.244]:7040 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S263771AbUAOWzd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:55:33 -0500
Date: Thu, 15 Jan 2004 14:55:19 -0800
From: "David S. Miller" <davem@redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, sim@netnation.com
Subject: Re: Linux 2.4.25-pre5
Message-Id: <20040115145519.79beddc3.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
References: <Pine.LNX.4.58L.0401151816320.17528@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004 18:19:40 -0200 (BRST)
Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:

> Here is -pre5.

If this is anything like the current 2.4.x BK tree, people will need this
in order to get a successful build:

--- Makefile.~1~	Thu Jan 15 12:13:10 2004
+++ Makefile	Thu Jan 15 12:13:12 2004
@@ -1,6 +1,6 @@
 VERSION = 2
 PATCHLEVEL = 4
-UBLEVEL = 25
+SUBLEVEL = 25
 EXTRAVERSION = -pre5
 
 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)
