Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbTILEtr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 00:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261680AbTILEtp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 00:49:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:30991
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S261677AbTILEsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 00:48:32 -0400
Subject: Re: [RFC] Enabling other oom schemes
From: Robert Love <rml@tech9.net>
To: Rahul Karnik <rahul@genebrew.com>
Cc: Chris Friesen <cfriesen@nortelnetworks.com>, rusty@linux.co.intel.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <3F614E36.7030206@genebrew.com>
References: <200309120219.h8C2JANc004514@penguin.co.intel.com>
	 <3F614912.3090801@genebrew.com> <3F614C1F.6010802@nortelnetworks.com>
	 <3F614E36.7030206@genebrew.com>
Content-Type: text/plain
Message-Id: <1063342102.700.237.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 00:48:22 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-09-12 at 00:40, Rahul Karnik wrote:

> I was referring to the "strict overcommit" mode described in 
> Documentation/vm/overcommit-accounting.

Right.  What Chris said is true.  Strict overcommit has limitations, and
hence it is not the default.

> To me, it sounded like it was 
> describing modes that were alternatives to the proposed kernel panic on 
> oom, and I was merely suggesting we use the same /proc/sys/vm method to 
> specify oom behavior (maybe a string rather than numeric codes in case 
> we have several such options in the future). Apologies if this is not 
> related to what Rusty is talking about.

I don't think the two are related.  You can have both, separately or
together.

	Robert Love


