Return-Path: <linux-kernel-owner+w=401wt.eu-S1752000AbWLQFV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbWLQFV1 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 00:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752005AbWLQFV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 00:21:27 -0500
Received: from userg501.nifty.com ([202.248.238.81]:60010 "EHLO
	userg501.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbWLQFV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 00:21:26 -0500
DomainKey-Signature: a=rsa-sha1; s=userg501; d=nifty.com; c=simple; q=dns;
	b=B1MRVMD+iovkBLjbK56B5vRtafBFGAWsKpMHJcQYaKfLfijsjQqUHbalqw9QUZ/A/
	o5N1BJgblg11JgBdq6jdA==
Date: Sun, 17 Dec 2006 23:23:11 +0900
From: Komuro <komurojun-mbn@nifty.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG KERNEL 2.6.20-rc1]  ftp: get or put stops during
 file-transfer
Message-Id: <20061217232311.f181302f.komurojun-mbn@nifty.com>
In-Reply-To: <20061217040222.GD17561@ftp.linux.org.uk>
References: <20061217212752.d93816b4.komurojun-mbn@nifty.com>
	<20061217040222.GD17561@ftp.linux.org.uk>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Dec 2006 04:02:22 +0000
Al Viro <viro@ftp.linux.org.uk> wrote:

> On Sun, Dec 17, 2006 at 09:27:52PM +0900, Komuro wrote:
> > 
> > Hello,
> > 
> > On kernel 2.6.20-rc1, ftp (get or put) stops
> > during file-transfer.
> > 
> > Client: ftp-0.17-33.fc6  (192.168.1.1)
> > Server: vsftpd-2.0.5-8   (192.168.1.3)
> > 
> > This problem does _not_ happen on kernel-2.6.19.
> > is it caused by network-subsystem change on 2.6.20-rc1??
> 
> Do you have NAT between you and server?

No. I don't have NAT between the client and the server.
Actually, the client and the sever is located in same room.


client -- 100MbpsHub -- server.

Thanks!

Best Regards
Komuro




