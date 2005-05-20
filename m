Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVETHPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVETHPh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 03:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVETHPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 03:15:37 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:50672 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261368AbVETHPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 03:15:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=rGzmoAnFCvHXIYUqpPTKOf4BwMmVsHlhzQurdQ2Ei5L15ArOS/fQ2E++mpCvdxR1DTN27m10WqUrowV8BZfIvXzzRti9Jye8ciAVs4hgbOXs0D4PKgkGM/+FZueGg7VRdwnLA32QpVTYbVy8hCOOZBLshGY6hp77ZJgRncHbVl0=
Date: Fri, 20 May 2005 16:15:13 +0900
From: Tejun Heo <htejun@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] kprobes-HERE!
Message-ID: <20050520071513.GA22944@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 I've implemented a very dumb and simple kprobes wrapper which
basically just prints "HERE!" messages.  It's consisted of a kernel
module and a perl script.  It compiles happily as an external module
without any modification to the kernel.  It only requires kprobes and
kallsyms to be compiled in.

 Message printing can be filtered on several conditions (uid, pid, irq
count...), and it also supports simple %x substitutions to report
runtime variables.  Please take a look at the following page for more
information.

 http://home-tj.org/kphere/

 Thanks.

-- 
tejun
