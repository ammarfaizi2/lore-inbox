Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752581AbWKAX4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbWKAX4o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752586AbWKAX4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:56:44 -0500
Received: from smtp.osdl.org ([65.172.181.4]:16355 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752581AbWKAX4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:56:43 -0500
Date: Wed, 1 Nov 2006 15:55:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Neil Horman <nhorman@tuxdriver.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       kernel-janitors@lists.osdl.org, kjhall@us.ibm.com, maxk@qualcomm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [KJ][PATCH] Correct misc_register return code handling in
 several drivers
Message-Id: <20061101155541.1e88a2f3.akpm@osdl.org>
In-Reply-To: <20061101135619.GA3459@hmsreliant.homelinux.net>
References: <20061023171910.GA23714@hmsreliant.homelinux.net>
	<1161660875.10524.535.camel@localhost.localdomain>
	<20061024125306.GA1608@hmsreliant.homelinux.net>
	<1161729762.10524.660.camel@localhost.localdomain>
	<20061101135619.GA3459@hmsreliant.homelinux.net>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2006 08:56:19 -0500
Neil Horman <nhorman@tuxdriver.com> wrote:

> 	Since Andrew hasn't incorporated this patch yet, and I had the time, I
> redid the patch taking Benjamin's INIT_LIST_HEAD and Joes mmtimer cleanup into
> account.  New patch attached, replacing the old one, everything except the
> aforementioned cleanups is identical.  

Please prepare a description for this patch.  The INIT_LIST_HEAD() in
misc_register() is mysterious.
