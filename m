Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266572AbUHZABl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUHZABl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 20:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUHYX5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:57:53 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:53206 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S266173AbUHYX5M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:57:12 -0400
Date: Thu, 26 Aug 2004 01:56:37 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: [patch *] remove 450 unnecessary #includes of sched.h 
In-Reply-To: <20040825180138.GA2793@holomorphy.com>
Message-ID: <Pine.LNX.4.53.0408260138080.14032@gockel.physik3.uni-rostock.de>
References: <20040819143907.GA4236@redhat.com> <20040819150632.GP11200@holomorphy.com>
 <20040825180138.GA2793@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2004, William Lee Irwin III wrote:

> I hereby declare open season on linux/sched.h!

OK, let's go!  ;-)

Let's see how often we can kill it's include lines. To start from a clean
base, I looked at vanilla 2.6.8.1 first before trying out your patches.

analysis was i386-only, my personal config builds, allyesconfig does not
(neither does it with an unpatched kernel)

no signed-off line, since this patch is just for fun and not to be 
included into any serious tree (yet). 

No patch either, since I just realized it's over 200k in size. So here's 
the URL:
   
http://www.physik3.uni-rostock.de/tim/kernel/2.6/desched-2.6.8.1-02.patch.gz

Tim
