Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTE0FY6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 01:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263503AbTE0FY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 01:24:58 -0400
Received: from holomorphy.com ([66.224.33.161]:13520 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263496AbTE0FY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 01:24:57 -0400
Date: Mon, 26 May 2003 22:38:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: pgcl-2.5.70-1
Message-ID: <20030527053805.GD19818@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brute-force merge to 2.5.70. Contains the pagetable fragmentation fixes,
but a new regression appears to have been introduced where active pages
are found on the inactive queue. Under investigation.

Unified anonymizing fault handling is on hold until this is worked out.
Once merged that should further reduce internal fragmentation of
anonymous memory and handle fragmentation on COW faults.


Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/vm/pgcl/


-- wli
