Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbTJUFiK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 01:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbTJUFiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 01:38:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25756 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262910AbTJUFiJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 01:38:09 -0400
Date: Mon, 20 Oct 2003 22:32:37 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: noah@caltech.edu, acme@conectiva.com.br, rddunlap@osdl.org,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Make LLC2 compile with PROC_FS=n
Message-Id: <20031020223237.31854ab5.davem@redhat.com>
In-Reply-To: <20031020101607.76e02647.shemminger@osdl.org>
References: <Pine.GSO.4.58.0310171452540.13905@blinky>
	<20031020101607.76e02647.shemminger@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Oct 2003 10:16:07 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> Why make up a whole separate llc_proc.h file for two prototypes? 
> Put them on the end of llc.h

I definitely prefer this version of the fix.

Since Arnaldo appears to be busy, I'll apply this.

Thanks Noah and Stephen.
