Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751015AbVK3WS7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751015AbVK3WS7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 17:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVK3WS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 17:18:59 -0500
Received: from web34104.mail.mud.yahoo.com ([66.163.178.102]:45170 "HELO
	web34104.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751015AbVK3WS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 17:18:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=VELmlrnJBAvTn8lBtUuXrJmj2QM/+pN2KtcXYAQLCGgxhhsDjEc+wg1uugjp9DqpoqK5g2w1yA4003cx4Qpvt9rgRfpLy/XfZqpfXBxuxD3oGYs1KzldVYlM9yFxi1G/dlFc+nUsIztAHTTHEuwxhseX0cHahrtJwoxvb8w3Bkc=  ;
Message-ID: <20051130221857.78282.qmail@web34104.mail.mud.yahoo.com>
Date: Wed, 30 Nov 2005 14:18:57 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Keith Mannthey <kmannth@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a762e240511301342x6e754cafsed9db386d05a6b2b@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Keith Mannthey wrote:
> You are still reporing free pages.  Do you seen the OOM killer killing
> processes?

I did not see anything being killed from the run under single user mode.
However, the sysrq does scroll past, so I only see the final 60 lines.
Is there a fool-proof way to check?

> 
> How big is the file you are doing your test on?  How big is your
> filesize var when the box hangs?

The File starts empty (the program creates it).  The box hangs when the file is 5.9GB
(6308233217), or at least this is the file size when the box comes back.

> 
> If you run this test without nfs (on a local file system) do you end
> up in this low memory state as well or only over a nfs mount?

I only see problems when running on nfs.

Other details:
nfs options:
rw,v3,rsize=32768,wsize=32768,hard,intr,lock,proto=tcp,addr=x.x.x.x

This is going over a dedicated Gb x-over cable to a clustered NetApp.

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
