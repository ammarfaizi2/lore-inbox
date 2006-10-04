Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030454AbWJDKII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030454AbWJDKII (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 06:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030791AbWJDKII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 06:08:08 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:24723 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1030454AbWJDKIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 06:08:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer;
        b=mTYD4xYsGIfg/J6+JD3CFWehBj5dpQ9X046lX+JmAmP6c7l3nNlpsJQVhnkxGZqsLt8KHiegsf7e36uNkCIspBHkkquX1VVAEXjUURBeU/HnRQjhJT1WNxa6ibojPClXoVrt3/CmueOF1iR6S9f10F8fjxYD/igElSh01/ltQJo=
Mime-Version: 1.0 (Apple Message framework v749)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28EE04D1-1645-4D2C-9D8B-FB4877779223@gmail.com>
Cc: linux-ide@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: girish <girishvg@gmail.com>
Subject: PCI/IDE generic IDE driver + bus master DMA logic errors
Date: Wed, 4 Oct 2006 19:07:58 +0900
To: linux-kernel@vger.kernel.org
X-Mailer: Apple Mail (2.749)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


our hardware guys are designing an pci/ide controller which has  
interrupt wrapper such that the ide & bus master interrupts are  
packaged & delivered together.
according to current linux ide sub-system believe i have to do  
something like implement ide_ack_intr(). quite clear. would like to  
know how to escalate bus-master dma or device errors, on return from  
ide_ack_intr?

