Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261889AbVGERmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbVGERmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 13:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVGERmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 13:42:50 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:51134 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261920AbVGERkM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 13:40:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tXukeuAt+qnmcWrVqq1m1zQ6LMcbP6DAPEZmfUzpYGfe9Ish7Ofrw99vrxvORJzXNftEJMMjzzfd/yBFclwOEmNwbRu6t6w8wGptgub6N4MeBn6Xr0WPNtr6xC8KIAswnR3qhxAEWCuVnlf2rrw9R+u2zpXQ+UG9lNE710k5OBw=
Message-ID: <4ae3c14050705104032eee518@mail.gmail.com>
Date: Tue, 5 Jul 2005 13:40:11 -0400
From: Xin Zhao <uszhaoxin@gmail.com>
Reply-To: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6: NFS problem---cannot rmmod nfsd
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I compile kernel 2.6.11.10 and configure both nfs client and server as
kernel modules.  But after I reboot the machine and did
"/etc/init.d/nfs start", the nfsd module is inserted. But when I tried
to rmmod this module either with "/etc/init.d/nfs stop" or "umount
/proc/fs/nfsd; rmmod nfsd",  the nfsd reference count is always 1 and
cannot be removed.  Why?

Thanks in advance for your kind help!

-x
