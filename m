Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTKSV1A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 16:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264163AbTKSV1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 16:27:00 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:12680
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S264155AbTKSV07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 16:26:59 -0500
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
cc: greg@kroah.com
Subject: Re: [USB] uhci-hcd.c: b400: host controller halted after ACPI S3
Message-Id: <E1AMZqy-0005qp-00@penngrove.fdns.net>
Date: Wed, 19 Nov 2003 13:27:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It also does this after suspend-to-disk (either flavor), which is reported
in Bugzilla:

	http://bugzilla.kernel.org/show_bug.cgi?id=1373

It's probably worthwhile adding that it fails similarly with ACPI S3 (in
addition to S4 as already reported).

    Oh! Good! I'm also trying to get this fixed, but I haven't seen any
    progress on this issue (if my memory serves me well, Greg hadn't access
    to a system with UHCI-HCD host controller to test).

Please, PLEASE, if you think you have a patch and you would like a report
on, send it to me and i'll at least try running it [after Friday], perhaps
even try to debug it.  Thank you for your efforts!

			         -- JM
