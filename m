Return-Path: <linux-kernel-owner+w=401wt.eu-S1751833AbWLQECZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833AbWLQECZ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 23:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbWLQECZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 23:02:25 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51411 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751833AbWLQECY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 23:02:24 -0500
Date: Sun, 17 Dec 2006 04:02:22 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Komuro <komurojun-mbn@nifty.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG KERNEL 2.6.20-rc1]  ftp: get or put stops during file-transfer
Message-ID: <20061217040222.GD17561@ftp.linux.org.uk>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 17, 2006 at 09:27:52PM +0900, Komuro wrote:
> 
> Hello,
> 
> On kernel 2.6.20-rc1, ftp (get or put) stops
> during file-transfer.
> 
> Client: ftp-0.17-33.fc6  (192.168.1.1)
> Server: vsftpd-2.0.5-8   (192.168.1.3)
> 
> This problem does _not_ happen on kernel-2.6.19.
> is it caused by network-subsystem change on 2.6.20-rc1??

Do you have NAT between you and server?
