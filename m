Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUJZBop@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUJZBop (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 21:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261986AbUJZBm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 21:42:27 -0400
Received: from zeus.kernel.org ([204.152.189.113]:471 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261943AbUJZBXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 21:23:00 -0400
Date: Mon, 25 Oct 2004 16:32:39 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org
Subject: Re: 2.6.9-mm1: timer_event multiple definition
In-Reply-To: <417D8725.8020900@mvista.com>
Message-ID: <Pine.LNX.4.58.0410251629530.1450@schroedinger.engr.sgi.com>
References: <20041022032039.730eb226.akpm@osdl.org> <20041022135026.GC2831@stusta.de>
 <Pine.LNX.4.58.0410220812170.7868@schroedinger.engr.sgi.com>
 <417D8725.8020900@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Oct 2004, George Anzinger wrote:

> Is there a reason (i.e. it is no longer true) for deleting the comment
> referenced by the first chunk below?  Knowing why things are done they way they
> are tends to prevent inadvertent changes that don't work :)

timer_notify_task() no longer exists and the function that replaces it
works in a different way. I also found that the description was not too
helpful in explaining what was going on and slightly wrong due to other
changes. Source was clearer
