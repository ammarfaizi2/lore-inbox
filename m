Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262981AbUJ1Lma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262981AbUJ1Lma (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbUJ1LlN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:41:13 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:18683 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S262981AbUJ1LiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:38:11 -0400
Date: Thu, 28 Oct 2004 12:38:08 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com
Subject: sparc ffb drm driver...
Message-ID: <Pine.LNX.4.58.0410281222450.15369@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This driver is broken and has been since my first CVS merge went in back
in April, I just noticed there now when trying to fix it up for some other
changes that I was making,

List of issues:
a) no-one has complained or noticed it has been broken for at least 4
months
b) there is no current user space to go with the kernel space driver (Mesa
DRI driver is broken as far as I know....)
c) no-one has stepped up to maintain it
d) no-one has a working user space to tell me I broke the kernel space or
test it for me ..

Unless we can up with some plan for the future (user and kernel space),
this driver will be marked broken in my next merge and may in fact end
up broken as a side effect of the changes for the core/personality split..

Dave.

p.s. I'd love to take it on, but I've no sparc hardware and no real spare
time even if I had...

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

