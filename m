Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTISHQ0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:16:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTISHQ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:16:26 -0400
Received: from dsl092-233-042.phl1.dsl.speakeasy.net ([66.92.233.42]:1954 "EHLO
	whisper.qrpff.net") by vger.kernel.org with ESMTP id S261384AbTISHQZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:16:25 -0400
X-All-Your-Base: Are Belong To Us!!!
X-Envelope-Recipient: linux-kernel@vger.kernel.org
X-Envelope-Sender: oliver@klozoff.com
Message-ID: <3F6AAC9D.9010202@klozoff.com>
Date: Fri, 19 Sep 2003 03:13:33 -0400
From: Stevie-O <oliver@klozoff.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: follow_page gone?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It would appear that, starting with 2.4.19, follow_page -- a fairly friendly way 
to get the struct page backing a virtual address (as in vmalloc virtual) -- has 
been removed from mm.h and made static to mm/memory.c.  LXR shows that this 
function was present in 2.4.18; the Changelog doesn't seem to mention anything 
about this (although I may have missed something, Changelog-2.4.19 is over 
100KB).  Is there a new way to do this?

Furthermore, is all of this stuff documented somewhere other than the various 
comments in the kernel source?

-- 
- Stevie-O

Real Programmers use COPY CON PROGRAM.EXE


