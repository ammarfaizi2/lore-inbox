Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264057AbUEXG2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264057AbUEXG2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 02:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264066AbUEXG2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 02:28:30 -0400
Received: from holomorphy.com ([207.189.100.168]:40071 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S264057AbUEXG17 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 02:27:59 -0400
Date: Sun, 23 May 2004 23:27:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Phy Prabab <phyprabab@yahoo.com>
Cc: Andrew Morton <akpm@osdl.org>, jakob@unthought.net,
       linux-kernel@vger.kernel.org
Subject: Re: Help understanding slow down
Message-ID: <20040524062754.GO1833@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Phy Prabab <phyprabab@yahoo.com>, Andrew Morton <akpm@osdl.org>,
	jakob@unthought.net, linux-kernel@vger.kernel.org
References: <20040523194352.4468da09.akpm@osdl.org> <20040524062337.97797.qmail@web90007.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524062337.97797.qmail@web90007.mail.scd.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 11:23:37PM -0700, Phy Prabab wrote:
> Sorry for the late reply.   No this is a dual Xeon
> 3.06Ghz.  All runs are with the same hardware and same
> make/build system.
> How do I generate a profile of the system.  I have
> alrady compiled profiling and have enabled the kernel.

readprofile -n -m /boot/System.map-`uname -r` | sort -rn -k 1,1 | head -22

No need for compiled-in support, just boot with profile=1.


-- wli
