Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbTILEry (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbTILEry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:47:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:29455
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261661AbTILEr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:47:26 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Robert Love <rml@tech9.net>
To: Rahul Karnik <rahul@genebrew.com>
Cc: rusty@linux.co.intel.com, riel@conectiva.com.br, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <3F614912.3090801@genebrew.com>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
	 <3F614912.3090801@genebrew.com>
Content-Type: text/plain
Message-Id: <1063342032.700.234.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 00:47:13 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 00:18, Rahul Karnik wrote:

> How does this interact with the overcommit handling? Doesn't strict 
> overcommit also not oom, but rather return a memory allocation error?

Right.  Technically, with strict overcommit and a sufficient overcommit
ratio, you cannot OOM.

But this is for people who do have a chance of OOM, because strict
overcommit is not for everyone.

> Could we not add another overcommit mode where oom conditions cause a 
> kernel panic?

The two are unrelated.

	Robert Love


