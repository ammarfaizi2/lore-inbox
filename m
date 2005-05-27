Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbVE0T0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbVE0T0n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 15:26:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262553AbVE0T0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 15:26:43 -0400
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:59321 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S262552AbVE0T0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 15:26:41 -0400
Message-ID: <4297746C.10900@ammasso.com>
Date: Fri, 27 May 2005 14:26:36 -0500
From: Timur Tabi <timur.tabi@ammasso.com>
Reply-To: linux-kernel@vger.kernel.org
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.5) Gecko/20041217 Mnenhy/0.7.2.0
X-Accept-Language: en-us, en, en-gb
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Will __pa(vmalloc()) ever work?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a driver that calls __pa() on an address obtained via vmalloc().  This is not 
supposed to work, and yet oddly it appears to.  Is there a possibility, even a remote one, 
that __pa() will return the correct physical address for a buffer returned by the 
vmalloc() function?

Also, does the pgd/pmd/pte page-table walking work on addresses returned by kmalloc(), or 
do I have to use __pa() to get the physical address?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com

One thing a Southern boy will never say is,
"I don't think duct tape will fix it."
      -- Ed Smylie, NASA engineer for Apollo 13
