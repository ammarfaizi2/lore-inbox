Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWEWCW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWEWCW7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 22:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWEWCW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 22:22:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:12944 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751012AbWEWCW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 22:22:58 -0400
Date: Mon, 22 May 2006 19:22:48 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-kernel@vger.kernel.org, chrisw@sous-sol.org
Subject: Re: cpusets: only wakeup kswapd for zones in the current cpuset
Message-Id: <20060522192248.b114fea3.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.62.0602081010440.2648@schroedinger.engr.sgi.com>
	<20060522182356.fbea4aec.pj@sgi.com>
	<Pine.LNX.4.64.0605221858250.7165@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> None if that is the case.

Take a look at wakeup_kswapd() for yourself ;).
No need to speculate.

Do you recall why you posted this patch?  The
wording made it sound like you had hit some
problem with waking up kswapd for all the nodes.

If you really saw that, then it would seem that
we still have a problem, that is now lacking a fix.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
