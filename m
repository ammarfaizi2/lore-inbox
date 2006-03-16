Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752206AbWCPHDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbWCPHDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 02:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752211AbWCPHDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 02:03:49 -0500
Received: from web8702.mail.in.yahoo.com ([203.84.221.123]:52661 "HELO
	web8702.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1752206AbWCPHDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 02:03:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=N7kZszXnITio6iH/gZ5YiQmd3yVSUPAxYE8WFtuhjVYTDmytbW45+3+ZyxxZrEzVOak3xwDARF38DmgPPaUmBb5QKORvi2PzadQYvt3bgGhLotKX2LxORQKBnaiot7vDlhQBW6NNMKN1d3+yXAuwcdy2Ap4fE86/4Sbds++ujgo=  ;
Message-ID: <20060316065930.85327.qmail@web8702.mail.in.yahoo.com>
Date: Thu, 16 Mar 2006 06:59:30 +0000 (GMT)
From: VISHAL NAHAR <naharvishalj@yahoo.co.in>
Subject: Invalidating a page of a user level process.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
   I am stuck up at invalidation of a   page of a user
level process.
Wht i am doin is that i am calling a device driver
ioctl func from a normal C prog in user space and
passing a virtual address into the ioctl func .In the
ioctl func (kernel space) i want to invalidate the
corresponding page.I have used funcs like pte_clear,
flush_tlb_page,page_remove_rmap,etc. but couldnt
succeed.Also suggest if any locks have to be acquired
.

Can anyone of u help me in page invalidation.I would
be grateful.
Thanking you  in advance

omkarlagu@yahoo.com


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
