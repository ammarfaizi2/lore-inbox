Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbULNQLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbULNQLT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbULNQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 11:11:19 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:8847 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261538AbULNQLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 11:11:12 -0500
Date: Tue, 14 Dec 2004 17:11:10 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Yihan Li <Yihan.Li@Edgewater.CA>
cc: linux-kernel@vger.kernel.org
Subject: Re: patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3
In-Reply-To: <002d01c4e1f5$a3491790$8500a8c0@WS055>
Message-ID: <Pine.LNX.4.61.0412141710150.24308@yvahk01.tjqt.qr>
References: <002d01c4e1f5$a3491790$8500a8c0@WS055>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Need help again!
> I am trying to patch RTAI (fusion-0.6.4) with kernel 2.6.9 on Fedora Core 3.
> The following steps are what I was following:
[...]
> After 8 mins, I get error messages as following:
> drivers/scsi/qla2xxx/qla_os.c: In function `qla2x00_queuecommand':
> drivers/scsi/qla2xxx/qla_os.c:315: sorry, unimplemented: inlining failed in
> call to 'qla2x00_callback': function not considered for inlining

Please see http://gcc.gnu.org/bugzilla/show_bug.cgi?id=18569
So to say, the module is not GCC-3.4 ready.



Jan Engelhardt
-- 
ENOSPC
