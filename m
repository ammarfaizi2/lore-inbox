Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbVF1RuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbVF1RuA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 13:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261516AbVF1RuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 13:50:00 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:25544 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262038AbVF1Rtr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 13:49:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GQ7VfOHZDY3uo8zON3EfXiI1ZkTqe7vAMR2O3nnSSpuSdtEpMKLWl1ab31DDhBZQPysAfy2nrIK+A+qY20IIsvtQTHBS+IaKjYtsGArgnWRlqgXRn/4vU7jZsPih0doo7UztswfeyXrKFCObYr2vQ311PviV/ncGZTv8SAjsdDA=
Message-ID: <94e67edf05062810497c7a20b5@mail.gmail.com>
Date: Tue, 28 Jun 2005 13:49:46 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Memory Management during Program Loading
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a query regarding memory management using Linux kernel.

In our system we have a secure physical memory starting and ending at 	
predefined addresses. We want to execute certain programs, which have 	
to be running secure in those address spaces only. 

Is it possible to force the loader to load the "particular" program 
(both the code and data segment) at that pre-defined secure physical 	
memory, without any major kernel changes?

Thanks,

Sreeni

(sreeni@nec-labs.com)
