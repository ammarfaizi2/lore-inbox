Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965211AbVKHW5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965211AbVKHW5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 17:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030388AbVKHW5o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 17:57:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:42130 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965302AbVKHW5d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 17:57:33 -0500
Date: Tue, 8 Nov 2005 14:57:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Jan Beulich" <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: don't blindly enable interrupts in die()
Message-Id: <20051108145721.2b98e6cf.akpm@osdl.org>
In-Reply-To: <4370AE63.76F0.0078.0@novell.com>
References: <4370AE63.76F0.0078.0@novell.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Jan Beulich" <JBeulich@novell.com> wrote:
>
>  Rather than blindly re-enabling interrupts in die(), save their state
>  upon entry and then restore that state.

What is the reason for this change?
