Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932689AbWAGAvi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932689AbWAGAvi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:51:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932688AbWAGAvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:51:38 -0500
Received: from nproxy.gmail.com ([64.233.182.207]:27543 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932538AbWAGAvh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:51:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VFMeuKADwlev5iHgyFxydzXuUNRkb01yT4ZjQWhSOOpG7BRJZIAmF/ENNlE0px7yQH1ONW3aX88axTgH5YXNbjYu5gUb9BXKj4qEY5m/xZamN0CjGBasZmW6YESGYTvBWKh77YFYd9O9PgzWMeuW7Dreht0/zwvx36oe7NgVgAU=
Message-ID: <447f2a8a0601061651v63441750s98d0ef83db6f1250@mail.gmail.com>
Date: Sat, 7 Jan 2006 00:51:35 +0000
From: Karen Lenska <karenlenska@googlemail.com>
To: linux-kernel@vger.kernel.org
Subject: Process Table-Process Control Block
Cc: karenlenska@googlemail.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wish to be personally CC'ed the answers/comments posted to the list
in response to this post



My questions are about Process ID, Process Control Block (PCB), and
Process Table (PT), and thread table



My old notes state that:

1- Each Process is allocated an identifier: Process ID (PID)

2- The PID indexes a process Table (PT)

3- Each process table entry contains a pointer to a relevant process ' PCB



However, this link

http://foldoc.org/?query=process+table&action=Search

states instead that  every process has an entry in the table. These
entries are known as process control blocks.





So I am just wondering, are the process table entries pointers to the
processes' PCB or rather the PCBs contents?



I think these entries include (among others) pointers to the PCBs
considering the latter expected size.



A second question do we use any hashing to index the process table
since the PIDs values seem not be allocated sequentially



Actually how PID values are allocated and how are they used to index
the process table (and afterwards the PCBs)



at the end, i presume that each process pcb contains a pointer to the
process thread table and that the thread table has more and less the
same structure than the process table, exempt that PCB contents is
different from Thread control block





Many thanks for your assistance
