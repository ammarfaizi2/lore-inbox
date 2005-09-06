Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750751AbVIFSLq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750751AbVIFSLq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 14:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVIFSLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 14:11:46 -0400
Received: from mailgw.aecom.yu.edu ([129.98.1.16]:58004 "EHLO
	mailgw.aecom.yu.edu") by vger.kernel.org with ESMTP
	id S1750751AbVIFSLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 14:11:46 -0400
Mime-Version: 1.0
Message-Id: <a06230906bf438c1b6065@[129.98.90.227]>
In-Reply-To: <91888D455306F94EBD4D168954A9457C03DF21EA@nacos172.co.lsil.com>
References: <91888D455306F94EBD4D168954A9457C03DF21EA@nacos172.co.lsil.com>
Date: Tue, 6 Sep 2005 14:12:04 -0400
To: "Moore, Eric Dean" <Eric.Moore@lsil.com>
From: Maurice Volaski <mvolaski@aecom.yu.edu>
Subject: RE: LSI Logic fusion mptscsih driver doesn't see devices under 2.
 6.13
Cc: linux-kernel@vger.kernel.org, mpt_linux_developer@lsil.com
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh. Thanks. It works again.

>We introduced split drivers for 2.6.13.  There are new layer drivers
>that sit ontop of mptscsih.ko.  These drivers are split along bus
>protocal, so there is mptspi.ko, mptfc.ko, and mptsas.ko.  This is
>to tie into the scsi transport layers that are split the same.
>
>If your using RedHat, you need to change mptscish to mptspi in
>/etc/modprobe.conf.
>If your using SuSE, you need to change mptscish to mptspi in
>/etc/sysconfig/kernel


-- 

Maurice Volaski, mvolaski@aecom.yu.edu
Computing Support, Rose F. Kennedy Center
Albert Einstein College of Medicine of Yeshiva University
