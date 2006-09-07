Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422628AbWIGRSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422628AbWIGRSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 13:18:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbWIGRSj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 13:18:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65158 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422628AbWIGRSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 13:18:38 -0400
Date: Thu, 7 Sep 2006 10:18:35 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] proc: Factor out an instantiate method from every
 lookup method.
Message-Id: <20060907101835.de6dd2b4.akpm@osdl.org>
In-Reply-To: <m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
References: <m1odttx8uz.fsf@ebiederm.dsl.xmission.com>
	<m1k64hx8rx.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Sep 2006 10:24:50 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> -/* SMP-safe */
> ...
> +/* SMP-safe */

Not the most useful comment in the kernel, and probably untrue, given that
it's /proc ;)

Please feel free to nuke such silliness sometime.
