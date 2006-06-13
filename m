Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWFMTYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWFMTYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 15:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWFMTYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 15:24:22 -0400
Received: from web53603.mail.yahoo.com ([206.190.37.36]:30119 "HELO
	web53603.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751178AbWFMTYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 15:24:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=IHCLoAjNmuaNZqD1UNO5tWyRUb+bqCV4L/rkH+kmGzNmf8hcbtWaIPojoECQERGaO1PpxgpOIBaXc6vasCsz0Kl+5CheYcmgh9ULxsn/sJC/3iWm4EQM7vLvxpbCaoSXzg6pQAYXonLL4V5GVwD1knTWZTvPs9Ii/8StQjcMIhg=  ;
Message-ID: <20060613192420.49742.qmail@web53603.mail.yahoo.com>
Date: Tue, 13 Jun 2006 12:24:20 -0700 (PDT)
From: Jason <bofh1234567@yahoo.com>
Subject: SO_REUSEPORT and multicasting
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote a program that uses multicasting to send data.
 It works great on HP-UX but does not work on Fedora
Core 5.  I emailed the fedora list but they were of
little to no help.  

Does the kernel support SO_REUSEPORT?  If so can
anyone give me some suggestions why my program does
not work on Linux?  I did a route add -net 224.0.0.0/4
dev eth0 but that did not do anything.

Thanks,
Jesse

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
