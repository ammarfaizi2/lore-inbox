Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbULUJYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbULUJYv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 04:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbULUJYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 04:24:50 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:15037 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261450AbULUJYs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 04:24:48 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=HkGpHjVE/21xLWIJOMBP+OFlIMkMvBDVf8ycjhiXuAb3yXQC/PUHivQRKS3seEJ1vpRBzcp88AjFRfygAcLTVjiLsXa+E0aSUMpmqJbADt6xbcpQzosBdSNp138zPkKLI3WbpRjcxe0jvJrGu9jaGeLSCOpsJqDoppVFBO810NY=
Message-ID: <ace3f33d0412210124520d6c80@mail.gmail.com>
Date: Tue, 21 Dec 2004 14:54:47 +0530
From: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
Reply-To: srinivas naga vutukuri <srinivas.vutukuri@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Printk output on console
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Selva,
 
 I understood the question as where all/what all printks (with
 line nos and the file names)
 you are looking for is it. I think, in a normal printf  using the
 macros __FILE__ and __LINE__ will give that...
 
 ex:
 printk(KERN_ERR "%s: Driver Initialisation failed", __FILE__);
 Is this helpful...
 
Regards,
srinivas.
