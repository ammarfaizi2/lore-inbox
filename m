Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbVIZOGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbVIZOGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 10:06:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbVIZOGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 10:06:17 -0400
Received: from web8402.mail.in.yahoo.com ([202.43.219.150]:58984 "HELO
	web8402.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932136AbVIZOGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 10:06:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=seUqc39DiSSA98uSupHRw/+i9L/h4+BUy71AyaoE8oZ0332VtLrPm9hafAYQCW6Vkv2BtVFrOy786FwesKuzeuLnRkyheYt5zroY3rB4BjCC1fKdXaSPVz2KNvK47lgAh/NtNPt+BQqF0g/GmO1jf8zHOJjha7NGyrt38jCTFH8=  ;
Message-ID: <20050926140613.75109.qmail@web8402.mail.in.yahoo.com>
Date: Mon, 26 Sep 2005 15:06:13 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127742313.2103.27.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastien

Thanks for Your reply .. I am now trying for that
Sysbench ..

In the mean time i have executed test cases that are
under check folder in libposix package ...
Well I am getting following result ...
----------------------------------------------------
aio_cancel
aio_cancel: cancel error : 11 (Resource temporarily
unavailable)

real	0m0.017s
user	0m0.001s
sys	0m0.002s
aio_cancel_fd
aio_cancel_fd: cancel returned AIO_NOTCANCELED

real	0m0.004s
user	0m0.003s
sys	0m0.002s
aio_fsync
aio_fsync: fsync error 22 (Invalid argument)

real	0m0.003s
user	0m0.001s
sys	0m0.002s
aio_read_one

real	0m0.004s
user	0m0.001s
sys	0m0.003s
aio_read_one_sig
aio_read_one_sig: aio_read error: Invalid argument

real	0m0.003s
user	0m0.001s
sys	0m0.002s
aio_read_one_thread
aio_read_one_thread: aio_read error: Invalid argument

real	0m0.003s
user	0m0.000s
sys	0m0.003s
aio_read_one_thread_id
aio_read_one_thread_id: aio_read error: Invalid
argument

real	0m0.003s
user	0m0.000s
sys	0m0.003s
aio_suspend
aio_suspend: lio_listio failed (Invalid argument)

real	0m0.003s
user	0m0.000s
sys	0m0.003s
aio_suspend_timeout
aio_suspend_timeout: lio_listio failed (Invalid
argument)

real	0m0.003s
user	0m0.000s
sys	0m0.003s
aio_write_one

real	0m0.004s
user	0m0.000s
sys	0m0.004s
aio_write_one_sig
aio_write_one_sig: aio_write error: Invalid argument

real	0m0.003s
user	0m0.001s
sys	0m0.002s
aio_write_one_thread
aio_write_thread: aio_write error: Invalid argument

real	0m0.003s
user	0m0.002s
sys	0m0.002s
aio_write_one_thread_id
aio_write_one_thread_id: aio_write error: Invalid
argument

real	0m0.003s
user	0m0.000s
sys	0m0.003s
lio_listio_nowait
lio_listio_nowait: lio_listio failed: Invalid argument

real	0m0.003s
user	0m0.001s
sys	0m0.002s
lio_listio_wait
lio_listio_wait: lio_listio failed: Invalid argument

real	0m0.003s
user	0m0.001s
sys	0m0.002s
--------------------------------------
Apart from that two test cases aio_read_one_thread_id
and aio_write_one_thread_id are hanging ...

Can You please justify this behaviour ....
As most of the testcases are giving either
error(Invalid Argument ..) 

I have also executed same test cases for glibc but
their it is not showing this behaviour ...???

Thanks in advance 




		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
