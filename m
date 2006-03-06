Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWCFVmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWCFVmF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 16:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752426AbWCFVmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 16:42:04 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:53923 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751129AbWCFVmC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 16:42:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=eLR8RtCNiY9ywVh87N9ur8E7fZpgmBS71HH0R79G1u2sUk2Xe9Ht8z2pkA5/X9t5tJEn21Kb9KBbCt2oWiAjnNfh6FupOKYDawlkO27Al7RsTNPzcFC7qO9EVcDaDVTEC/TJU1MfenY34+pU5NcBbdoWGyl4RmKBMu6C3QaiJ1E=
Message-ID: <4ae3c140603061342r26ca2226s2e6e41792104c633@mail.gmail.com>
Date: Mon, 6 Mar 2006 16:42:01 -0500
From: "Xin Zhao" <uszhaoxin@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Why ext3 uses different policies to allocate inodes for dirs and files?
Cc: linux-fsdevel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The policy seems to distribute dir inodes uniformly on all block
groups. Why do we want to do this?  Isn't it better to create a dir
inode close to its parent dir inode?

Thanks in advance for your help!

Xin
