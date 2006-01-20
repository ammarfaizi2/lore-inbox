Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422712AbWATE5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422712AbWATE5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 23:57:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbWATE5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 23:57:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57065 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422712AbWATE5P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 23:57:15 -0500
Date: Thu, 19 Jan 2006 20:56:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: davem@davemloft.net, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Fix regression added by ppoll/pselect code.
Message-Id: <20060119205648.221fd3f0.akpm@osdl.org>
In-Reply-To: <1137732487.30084.194.camel@localhost.localdomain>
References: <20060119.164042.74751188.davem@davemloft.net>
	<1137732487.30084.194.camel@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> His patch also changed the simple powers of ten to the slightly
>  confusing 'NSEC_PER_SEC' and 'USEC_PER_SEC' macros, as if those numbers
>  are subject to change by later decree, and shouldn't be hard-coded.

a) They tell you what the magic numbers _mean_.

b) Ever tried counting nine contiguous zeros at 4AM, making sure that
   they're all there?
