Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263583AbTHZKmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 06:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263593AbTHZKmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 06:42:19 -0400
Received: from fw.osdl.org ([65.172.181.6]:58824 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263583AbTHZKmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 06:42:18 -0400
Date: Tue, 26 Aug 2003 03:44:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: mulix@mulix.org, arjanv@redhat.com, mingo@redhat.com,
       rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix
Message-Id: <20030826034458.35c54fbf.akpm@osdl.org>
In-Reply-To: <20030826103833.GX1715@holomorphy.com>
References: <20030825231449.7de28ba6.akpm@osdl.org>
	<Pine.LNX.4.44.0308260233550.20822-100000@devserv.devel.redhat.com>
	<20030826000218.2ceaea1d.akpm@osdl.org>
	<1061884611.2982.4.camel@laptop.fenrus.com>
	<20030826080759.GK13390@actcom.co.il>
	<20030826103833.GX1715@holomorphy.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> except you have the usual intractable disaster
>  whenever file-backed pages are anonymized via truncate().

They only arose due to races between major faults and truncate.
That got fixed.

