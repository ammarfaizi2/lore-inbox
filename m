Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264849AbUETCU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264849AbUETCU6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 22:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264851AbUETCU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 22:20:58 -0400
Received: from Jupiter.Toms.NET ([64.32.223.162]:20883 "EHLO jupiter.toms.net")
	by vger.kernel.org with ESMTP id S264849AbUETCU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 22:20:57 -0400
Date: Wed, 19 May 2004 22:20:52 -0400 (EDT)
From: Tom Oehser <tom@toms.net>
cc: linux-kernel@vger.kernel.org
Subject: klogd, netconsole without /dev/console?
In-Reply-To: <16527.63123.869014.733258@segfault.boston.redhat.com>
Message-ID: <Pine.LNX.4.58.0405192218420.1100@jupiter.toms.net>
References: <16519.58589.773562.492935@segfault.boston.redhat.com>
 <20040425191543.GV28459@waste.org> <16527.42815.447695.474344@segfault.boston.redhat.com>
 <20040428140353.GC28459@waste.org> <16527.47765.286783.249944@segfault.boston.redhat.com>
 <20040428142753.GE28459@waste.org> <16527.63123.869014.733258@segfault.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 If I start klogd with a -c, it turns off _both_ netconsole _and_ /dev/console.

 If I start klogd without -c, I get both of them on.

 Shouldn't there be a way to have klogd and netconsole but no /dev/console?

-Tom
