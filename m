Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751908AbWCCGMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbWCCGMS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 01:12:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWCCGMS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 01:12:18 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:8837 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751908AbWCCGMQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 01:12:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=f+fypjEOmA/9KmWPwvrdBRNFgr4epdsygHj2FCR9JzrTxYIgAsxOBwD1hcVpgkg1Crjq6brO/R6zW0zp7bnaEoN+AoVo7nMocvQ8H+CCI8BY8eZ+Xx2z+gc2GR5zh3We2Mrewtb5Ce13hrA1Nn2Px4Du6mi8ApHVjyX3LI3c2Ws=
Message-ID: <2399bdcc0603022212m840e7afy5337c1c7dbce434f@mail.gmail.com>
Date: Fri, 3 Mar 2006 07:12:10 +0100
From: "Johan Lundgren" <jrlundgren@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: KERNEL: assertion (!sk->sk_forward_alloc) failed
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have the same problem.

Upgraded to 2.6.16-rc5, the problem does not go away.

I also have intel nics and the e1000 driver. Upgraded to the latest
driver via intel website, that didn't fix it either.

The only fix is to turn "tcp segmentation offload" off. Not a good
solution.

Anyone got any idea? Is there a patch somewhere I can apply that
should fix this?

Regards,
Johan
