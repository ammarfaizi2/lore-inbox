Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbUCIROH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 12:14:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUCIROH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 12:14:07 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52136 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261925AbUCIROE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 12:14:04 -0500
Message-ID: <404DFB4F.1020208@pobox.com>
Date: Tue, 09 Mar 2004 12:13:51 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix von Leitner <felix-kernel@fefe.de>
CC: linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: tg3 error
References: <20040309170945.GA2039@codeblau.de>
In-Reply-To: <20040309170945.GA2039@codeblau.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> A machine at a customer's site (running kernel 2.4.21) has stopped
> answering over Ethernet today.  The machine itself was still there and
> the customer could log in at the console.  A reboot fixed the problem.
> 
> The machine has had these error messages in the syslog about once per
> hour for about 24 hours:
> 
> Mar  9 16:17:38 mail2 kernel: tg3: eth0: transmit timed out, resetting
> Mar  9 16:17:38 mail2 kernel: tg3: tg3_stop_block timed out, ofs=3400 enable_bit=2
> Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=2400 enable_bit=2
> Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=1400 enable_bit=2
> Mar  9 16:17:39 mail2 kernel: tg3: tg3_stop_block timed out, ofs=c00 enable_bit=2


AFAIK this is fixed in the latest upstream tg3...

	Jeff



