Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264766AbUEUAvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264766AbUEUAvu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 20:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUEUAvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 20:51:50 -0400
Received: from mail.fastclick.com ([205.180.85.17]:41410 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264766AbUEUAvt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 20:51:49 -0400
Message-ID: <40AD52A4.3060607@fastclick.com>
Date: Thu, 20 May 2004 17:51:48 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: How can I optimize a process on a NUMA architecture(x86-64 specifically)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Say you have a bunch of single-threaded processes on a NUMA machine. 
Does the kernel make sure to prefer allocations using a certain CPU's 
memory, preferring to run a given process on the CPU which contains its 
memory?  Or should I use the NUMA API(libnuma) to spell this out to the 
kernel? Does the kernel do the right thing in this case?


Thanks,

Brett

