Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270876AbTGPOb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 10:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270956AbTGPOb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 10:31:57 -0400
Received: from rth.ninka.net ([216.101.162.244]:29070 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S270876AbTGPOb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 10:31:56 -0400
Date: Wed, 16 Jul 2003 07:46:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Ben Collins <bcollins@debian.org>
Cc: zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] fix warning in iee1394 nodemgr
Message-Id: <20030716074637.253ee2fc.davem@redhat.com>
In-Reply-To: <20030716141008.GE685@phunnypharm.org>
References: <Pine.LNX.4.53.0307160159330.32541@montezuma.mastecende.com>
	<20030716141008.GE685@phunnypharm.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jul 2003 10:10:08 -0400
Ben Collins <bcollins@debian.org> wrote:

> I'm a little concerned that I've never seen either of the two warnings
> you showed. I've been building with -Werror for awhile now.

GCC generates slightly different flow graphs on different
platforms, and from version to version gcc's "might be used
uninitialized" accuracy varies :-)
