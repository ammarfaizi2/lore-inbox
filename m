Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVHWJmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVHWJmp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 05:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVHWJmp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 05:42:45 -0400
Received: from web8508.mail.in.yahoo.com ([202.43.219.170]:64399 "HELO
	web8508.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932113AbVHWJmo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 05:42:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=5pByEY5M+p3H+vupO6aXAWu7xgohoysUS5PlI1yC664uvrHZqP6e0MiJ0oRoJglJ7oRSdEavY2loKKHGSZjM56wYrIEeQat1ZaYFH3j0PkpgvloszSjwxDK72pHKFzK3ve2QNL4zCdPWYZ1zeKAcmuXNBvsM5zOq5pzLqYMgWME=  ;
Message-ID: <20050823094231.85102.qmail@web8508.mail.in.yahoo.com>
Date: Tue, 23 Aug 2005 10:42:31 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: kernel module seg fault
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have written a kernel module and I can load (insmod)
it without any error. But when i run my module it gets
seg fault at interruptible_sleep_on_timeout();

I have used this function in the following way:

DECLARE_WAIT_QUEUE_HEAD(wq);
init_waitqueue_head(&wq);
interruptible_sleep_on_timeout(&wq, 2);

I am using redhat version 9.0 and kernel version
2.4.20-8.
Could you please give some light on this issue?

Manomugdha Biswas


	

	
		
____________________________________________________
Send a rakhi to your brother, buy gifts and win attractive prizes. Log on to http://in.promos.yahoo.com/rakhi/index.html
