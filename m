Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262047AbVCIRDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262047AbVCIRDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 12:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCIRDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 12:03:20 -0500
Received: from rproxy.gmail.com ([64.233.170.202]:34794 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262047AbVCIRDP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 12:03:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=pMyVSOsWKpqhSVT/PjWPlO9g3pLpOrQk3QHO882Hnzjq5Wl1/wJ+OOxUb5YyspKwlCa+FGmIa612T3ij8DJPEJffr80zON5rPH/jtEUdDFvunMrpZIf3qTOrkDd+EdclWUAbedBRhgCOuXgFu42vK1Me6TSskGcayAIfy+NwSXg=
Message-ID: <9e47339105030909031486744f@mail.gmail.com>
Date: Wed, 9 Mar 2005 12:03:11 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: current linus bk, error mounting root
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something in the last 24hrs in linus bk broke my ability to mount root:

Creating root device
Mounting root filesystem
mount: error 6 mounting ext3
mount: error 2 mounting none
Switching to new root
Switchroot: mount failed 22
umount /initrd/dev failed: 2

If I back off a day everything works again. 

Root is on Intel ICH5 SATA drive.

-- 
Jon Smirl
jonsmirl@gmail.com
