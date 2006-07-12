Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWGLFBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWGLFBx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 01:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWGLFBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 01:01:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63897 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932216AbWGLFBw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 01:01:52 -0400
Date: Tue, 11 Jul 2006 22:01:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, mchehab@infradead.org
Subject: Re: [PATCH -mm] bttv: must_check fixes
Message-Id: <20060711220148.13257f96.akpm@osdl.org>
In-Reply-To: <20060711204421.be13dec9.rdunlap@xenotime.net>
References: <20060711204421.be13dec9.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 20:44:21 -0700
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> Check all __must_check warnings in bttv.

Thanks.

The descriptions do rather miss the point: the objective is not to squish the
__must_check warnings - it is to detect and handler error conditions.
