Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293131AbSCFNId>; Wed, 6 Mar 2002 08:08:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293516AbSCFNIY>; Wed, 6 Mar 2002 08:08:24 -0500
Received: from excore.hns.com ([139.85.52.104]:49100 "EHLO excore1.hns.com")
	by vger.kernel.org with ESMTP id <S293131AbSCFNIU>;
	Wed, 6 Mar 2002 08:08:20 -0500
To: linux-kernel@vger.kernel.org
Subject: Howto munge packets?
From: nbecker@fred.net (Neal D. Becker)
Date: 06 Mar 2002 08:08:14 -0500
Message-ID: <x88bse1rght.fsf@rpppc1.md.hns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We have a project that requires intercepting certain IP packets,
modifying their payload, and sending them on their way.  The
modification is nontrivial, and so I think it would best be done in
user space.  Can anyone suggest a general approach for how to
intercept packets, send them to user space, and then on to their
destination?  Should we look at netfilter/netlink?  I'd like to avoid
any kernel code.

TIA.
