Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757677AbWK0KCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757677AbWK0KCJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 05:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757679AbWK0KCJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 05:02:09 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:14157 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1757677AbWK0KCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 05:02:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=YSM1UC/rhhHXZnBGNRM6IKsvzYeNb6cZAm4Gxvn/N6ZPIL0avgRJcR6D9pi+kiRufTZTzkRoP4PxAx12nK4LvUrOnk7fV/VcGFA6AMcXm72i/RlBIqz8WGea5fSXHZ82z9MTj34c5rhzdUqI3uPOJP6/6C6RTn4wD5CawTRCAe8=
Message-ID: <ac8af0be0611270202i54e376b5jedf91fd7cba35434@mail.gmail.com>
Date: Mon, 27 Nov 2006 02:02:06 -0800
From: "Zhao Forrest" <forrest.zhao@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Which patch fix the 8G memory problem on x64 platform?
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

The kernel 2.6.18.3 runs very well on my x64 server with 2 CPU's and
8G memory; however kernel 2.6.16.32 kernel panic(Kernel panic - not
syncing: Attempted to kill init) under the stress test. After I use
mem=4000M for kernel 2.6.16.32, the kernel panic doesn't happen under
stress test.

This bug also happens with latest sles10 kernel(2.6.16.21-0.25-smp),
which is based on 2.6.16.21.

Do you know what patch fixed this bug between  2.6.16.32 and 2.6.18.3?
Then we could backport the patch to both 2.6.16.32 and sles10 kernel.

Thanks,
Forrest
