Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUBLE7s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266279AbUBLE7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:59:48 -0500
Received: from fw.osdl.org ([65.172.181.6]:20180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266277AbUBLE7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:59:47 -0500
Date: Wed, 11 Feb 2004 20:59:51 -0800
From: Andrew Morton <akpm@osdl.org>
To: MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __release_region() race
Message-Id: <20040211205951.05c72250.akpm@osdl.org>
In-Reply-To: <20040212.135001.85390321.maeda@jp.fujitsu.com>
References: <20040212.135001.85390321.maeda@jp.fujitsu.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAEDA Naoaki <maeda.naoaki@jp.fujitsu.com> wrote:
>
> I think __release_region() must hold a writer lock as well as
>  __request_region() does.

Me too.  Thanks.
