Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263862AbUCZAcr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 19:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263859AbUCZAcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 19:32:04 -0500
Received: from fw.osdl.org ([65.172.181.6]:11478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263865AbUCZANO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 19:13:14 -0500
Date: Thu, 25 Mar 2004 16:15:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Matt Mackall <mpm@selenic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/22] /dev/random: remove broken resizing sysctl
Message-Id: <20040325161523.3efbb4b7.akpm@osdl.org>
In-Reply-To: <4.524465763@selenic.com>
References: <3.524465763@selenic.com>
	<4.524465763@selenic.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall <mpm@selenic.com> wrote:
>
> /dev/random  remove broken resizing sysctl

This could break things.  Shouldn't we leave the /proc entry there
and print a friendly message in the sysctl handler?
