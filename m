Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbUASRtV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:49:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbUASRtV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:49:21 -0500
Received: from pizda.ninka.net ([216.101.162.242]:36497 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263088AbUASRtT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:49:19 -0500
Date: Mon, 19 Jan 2004 09:38:23 -0800
From: "David S. Miller" <davem@redhat.com>
To: Paul Mackerras <paulus@samba.org>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rusty@rustcorp.com.au, rth@twiddle.net, davidm@napali.hpl.hp.com
Subject: Re: [PATCH] sort exception tables
Message-Id: <20040119093823.68f94083.davem@redhat.com>
In-Reply-To: <16395.47717.472261.52870@cargo.ozlabs.ibm.com>
References: <16395.47717.472261.52870@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 22:07:17 +1100
Paul Mackerras <paulus@samba.org> wrote:

> I have tested this on x86 and ppc with a module that uses __get_user
> in an init function, deliberately laid out to get the exception table
> out of order, and it works (whereas it oopsed without this patch).

I have no objections to this patch, however I'd like to be reminded why we
desire to sort this stuff, performance?
