Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753100AbWKGU3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100AbWKGU3W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 15:29:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbWKGU3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 15:29:22 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12467 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753100AbWKGU3V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 15:29:21 -0500
Date: Tue, 7 Nov 2006 12:29:04 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com,
       Jonathan E Brassow <jbrassow@redhat.com>
Subject: Re: [PATCH 2.6.19 4/5] dm: raid1: fix waiting for io on suspend
Message-Id: <20061107122904.a49861be.akpm@osdl.org>
In-Reply-To: <20061107183243.GF6993@agk.surrey.redhat.com>
References: <20061107183243.GF6993@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Nov 2006 18:32:43 +0000
Alasdair G Kergon <agk@redhat.com> wrote:

> +DECLARE_WAIT_QUEUE_HEAD(_kmirrord_recovery_stopped);

I'll make this static.
