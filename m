Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbVLBXXO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbVLBXXO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 18:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVLBXXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 18:23:14 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:9995 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751117AbVLBXXN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 18:23:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FyGfjqZZRQs22G8oKsq3VwDdyUSmWFOim+N6t76CPMxach+1Syw9S/4gD+YXZZKtTfBmciqLDiigqB0zHj7XdpFc0ohdYDBb/GZxgy7f+FNKpbMPkGdbUDgSYOJAgMRN11v9OsjugUhYmbEsErjfY+t8+p+D369qCsTSfhGiRc0=
Message-ID: <4ae3c140512021523n68adee1anbc82f99f3d8f5554@mail.gmail.com>
Date: Fri, 2 Dec 2005 18:23:09 -0500
From: Xin Zhao <uszhaoxin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Can a filesystem use a separate dcache?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The filesystem I am writing might need a separated dcache so that the
dentry of this filesystem objects are maintained in that dentry cache
space.  Is this possible? If possible, where shall I start with? The
workload to setup a separate dcache seems to be very high though. :(

Can someone guide me to the right direction?

Thanks,
Xin
