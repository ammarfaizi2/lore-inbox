Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWCTWLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWCTWLq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 17:11:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030573AbWCTWJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 17:09:38 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63710 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030566AbWCTWIx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 17:08:53 -0500
Date: Mon, 20 Mar 2006 14:05:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org, dm-devel@redhat.com
Subject: Re: dm: bio split bvec fix
Message-Id: <20060320140534.1feeccca.akpm@osdl.org>
In-Reply-To: <20060320192155.GU4724@agk.surrey.redhat.com>
References: <20060320192155.GU4724@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alasdair G Kergon <agk@redhat.com> wrote:
>
> The code that handles bios that span table target boundaries by breaking
>  them up into smaller bios will not split an individual struct bio_vec
>  into more than two pieces.  Sometimes more than that are required.
> 
>  This patch adds a loop to break the second piece up into as many
>  pieces as are necessary.

Should this go into 2.6.16.1?
