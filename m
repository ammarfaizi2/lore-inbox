Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264716AbTAYX3c>; Sat, 25 Jan 2003 18:29:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbTAYX3c>; Sat, 25 Jan 2003 18:29:32 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30362 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S264716AbTAYX3c>; Sat, 25 Jan 2003 18:29:32 -0500
Date: Sat, 25 Jan 2003 15:38:36 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Hugh Dickins <hugh@veritas.com>
cc: "Randy.Dunlap" <rddunlap@osdl.org>, rpjday@mindspring.com,
       linux-kernel@vger.kernel.org
Subject: Re: test suite?
Message-ID: <73470000.1043537913@titus>
In-Reply-To: <20030125232306.GZ780@holomorphy.com>
References: <Pine.LNX.4.33L2.0301241741470.9816-100000@dragon.pdx.osdl.net> <Pine.LNX.4.44.0301252011420.1784-100000@localhost.localdomain> <20030125232306.GZ780@holomorphy.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's actually a relatively annoying limit, as various boxen's MP tables
> ACPI tables etc. etc. are well above 8MB. At some point one of us should
> quash that issue permanently and dynamically map the things. IIRC Linux
> needs NUMA-Q boxen to get lynxers reflashed to move MP tables below 8MB
> to boot atm. mbligh can more accurate describe the pain involved there.
> As for the bzImage, don't bother supporting excess bloat.

One of these days, I just need to make it remap the MPS tables with
set_fixmap instead, would be a damned sight easier. Was quicker just
to hack the firmware at the time, but it's not the RightThingToDo.

M.

