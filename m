Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263856AbTIICQD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 22:16:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263860AbTIICQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 22:16:02 -0400
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:26642
	"EHLO gw.goop.org") by vger.kernel.org with ESMTP id S263856AbTIICQB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 22:16:01 -0400
Subject: Re: [PATCH] use group_leader->pgrp (was Re: setpgid and threads)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030908191215.22f501a2.akpm@osdl.org>
References: <1061424262.24785.29.camel@localhost.localdomain>
	 <20030820194940.6b949d9d.akpm@osdl.org>
	 <1063072786.4004.11.camel@localhost.localdomain>
	 <20030908191215.22f501a2.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1063073637.4004.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 08 Sep 2003 19:13:58 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-08 at 19:12, Andrew Morton wrote:
> and to then rename task_struct.pgrp to something else, to pick up any
> missed conversions?

Probably a good idea.  I was also thinking about renaming "group_leader"
to something which tells you which kind of group its the leader of.  Or
at least commenting it.

	J

