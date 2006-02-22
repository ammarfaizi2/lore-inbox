Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWBVWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWBVWsF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWBVWsE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:48:04 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:51420 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750981AbWBVWsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:48:02 -0500
Date: Wed, 22 Feb 2006 14:47:42 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 2/3] revert "Optimize sys_times for a single thread
 process"
In-Reply-To: <43FCE6AC.ED8BC108@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0602221446080.30219@schroedinger.engr.sgi.com>
References: <43FCE6AC.ED8BC108@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Oleg Nesterov wrote:

> tasklist_lock in sys_times() will be eliminated completely
> by further patch.

Where is that patch? The patch would simply drop the locks?

