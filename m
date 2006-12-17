Return-Path: <linux-kernel-owner+w=401wt.eu-S1751808AbWLQDun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWLQDun (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 22:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWLQDun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 22:50:43 -0500
Received: from defg501.nifty.com ([202.248.238.128]:29089 "EHLO
	defg501.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbWLQDum (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 22:50:42 -0500
X-Greylist: delayed 1476 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Dec 2006 22:50:42 EST
DomainKey-Signature: a=rsa-sha1; s=userg503; d=nifty.com; c=simple; q=dns;
	b=QDB+vk3bLMJ2Q2G0hGJV9zTECxFUwUwbUmZaP7Eq7LObAzMmph5H2PPiRIRa+xK82
	sX12B15T2EDnGA1tBBzgQ==
Date: Sun, 17 Dec 2006 21:27:52 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: linux-kernel@vger.kernel.org
Subject: [BUG KERNEL 2.6.20-rc1]  ftp: get or put stops during file-transfer
Message-Id: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

On kernel 2.6.20-rc1, ftp (get or put) stops
during file-transfer.

Client: ftp-0.17-33.fc6  (192.168.1.1)
Server: vsftpd-2.0.5-8   (192.168.1.3)

This problem does _not_ happen on kernel-2.6.19.
is it caused by network-subsystem change on 2.6.20-rc1??


Best Regards
Komuro

