Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264647AbUD1G3I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264647AbUD1G3I (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264650AbUD1G3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:29:07 -0400
Received: from mail.tpgi.com.au ([203.12.160.61]:19343 "EHLO mail4.tpgi.com.au")
	by vger.kernel.org with ESMTP id S264647AbUD1G3F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:29:05 -0400
Date: Wed, 28 Apr 2004 16:18:44 +1000
From: "Nigel Cunningham" <ncunningham@linuxmail.org>
To: "Chris Siebenmann" <cks@utcc.utoronto.ca>
Subject: Re: What does tainting actually mean?
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Reply-To: ncunningham@linuxmail.org
References: <04Apr28.020259edt.41801@gpu.utcc.utoronto.ca>
Content-Type: text/plain; format=flowed; delsp=yes; charset=us-ascii
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <opr65k5ivcshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <04Apr28.020259edt.41801@gpu.utcc.utoronto.ca>
User-Agent: Opera M2/7.50 (Linux, build 663)
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 28 Apr 2004 02:02:55 -0400, Chris Siebenmann  
<cks@utcc.utoronto.ca> wrote:
>  What happens when a binary module thinks it knows the size of a
> structure and is wrong? What happens when a binary module has a
> concurrency problem, in any of the many forms they manifest in the Linux
> kernel?

Good points. It could be really difficult to trace the cause of those  
issues. But hard/too much effort != impossible. For every entry point to  
the module we have a known state of the system prior to and after the  
call. We could potentially checksum the whole of memory before and after  
and find out exactly what the module has changed.

Anyway, I'm going to drop this conversation now. Work to do :>

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614, Australia.
+61 (2) 6251 7727 (wk)
