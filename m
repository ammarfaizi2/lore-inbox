Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULXPvZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULXPvZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 10:51:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbULXPvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 10:51:25 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55949 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261188AbULXPvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 10:51:22 -0500
Subject: 2.4.28, 64GB highmem, keyboard conflict on Tyan MB
From: "James D. Freels" <freelsjd@comcast.net>
Reply-To: freelsjd@comcast.net
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: self
Date: Fri, 24 Dec 2004 10:51:19 -0500
Message-Id: <1103903479.4912.15.camel@pcp483125pcs.oakrdg01.tn.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have two dual-processor Xeon machines set up in a similar manner.
Both have 4GB of main memory.  Machine A utilizes an Intel MB.  In order
to take advantage of all the memory, the 64GB highmem option must be
selected.  If I select only the 4GB option, not quite all of the memory
is used.  Everything works fine on this machine.

Machine B utilizes a Tyan MB.  If I select the 4GB highmem option,
everything works fine except not all the memory is available (only
3616824K shows from "top").  Now if I try to select the 64GB highmem
option similar to Machine A (after recompiling the kernel and trying to
boot), the machine will not boot and the error message displayed to the
console says "missing keyboard".

I have a true ps/2 keyboard on both machines as well as ps/2 mouse.

How can I correct this problem ?  Will I need to change to a USB
keyboard/mouse for this MB ?


