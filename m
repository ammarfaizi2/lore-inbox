Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUDCSMV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 13:12:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUDCSMV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 13:12:21 -0500
Received: from mx1.redhat.com ([66.187.233.31]:65412 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261851AbUDCSMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 13:12:18 -0500
Date: Sat, 3 Apr 2004 13:12:07 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Andrew Morton <akpm@osdl.org>,
       Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: oom-killer adjustments
In-Reply-To: <20040403000447.GU3328@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.44.0404031311400.30015-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.LNX.4.44.0404031311402.30015@chimarrao.boston.redhat.com>
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Apr 2004, Kurt Garloff wrote:

> 1 << [-16 .. 15], thus allowing the sysadmin to mark the importance of
> a process. 

Shouldn't such an adjustment be inherited at fork time,
if we decide we want it in the kernel ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

