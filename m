Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263026AbUKYJ0g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263026AbUKYJ0g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Nov 2004 04:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbUKYJ0g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Nov 2004 04:26:36 -0500
Received: from wproxy.gmail.com ([64.233.184.202]:28827 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263027AbUKYJZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Nov 2004 04:25:01 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uoRddwgELFw/CT/a/0jz8hgJo4JyK1/JcnBV/PTU/HdEloz1SXQJBWGw3v6PcGX/YoO3hcX45yIfxEsDHIj2Y6CDJuT2Aaw/nSsVaLkV+2qyKFyieVvcLo8ooo8ik0t5unDVddjPdH4TKscQ5tBNXDJPlEvaNoicu+pOfQi9Gcg=
Message-ID: <81b0412b04112501253810acba@mail.gmail.com>
Date: Thu, 25 Nov 2004 10:25:00 +0100
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: vmstat: zero cs | system debug
In-Reply-To: <20041123133805.GF3775@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041123133805.GF3775@schottelius.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Nov 2004 14:38:05 +0100, Nico Schottelius
<nico-kernel@schottelius.org> wrote:
> - what could I have done to find out the problem?
> -> I did ps axu, vmstat, cat /proc/mdstat, free, netstat -an

uname -a, lsmod, free, cat /proc/slabinfo (slabtop)
ps aux -L (to show threads)

> - what todo to fix the problem?
> -> tried killall -9 smbd apache ...

SAK (Alt-SysRq-K) - kill everyone except init
