Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264371AbUHBWeq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264371AbUHBWeq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbUHBWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:34:32 -0400
Received: from ozlabs.org ([203.10.76.45]:18851 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264371AbUHBWeJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:34:09 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16654.49389.304058.800578@cargo.ozlabs.ibm.com>
Date: Tue, 3 Aug 2004 08:32:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, kkeil@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: "Fix" broke PPP filtering
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a changeset that went into Linus' tree on 9 April with the
title "[ISDN]: Fix kernel PPP/IPPP active/passiv filter code",
attributed to kkeil@suse.de.  The change to ppp_generic.c in that
changeset means that the active-filter option in pppd no longer
works.

Why was the change to ppp_generic.c made?

Paul.
