Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268733AbUJKJPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268733AbUJKJPb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268734AbUJKJPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:15:31 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:16108 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S268733AbUJKJP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:15:27 -0400
In-Reply-To: <200410102315.i9ANF7OI019460@hacksaw.org>
References: <200410102315.i9ANF7OI019460@hacksaw.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <047CCB21-1B66-11D9-96AD-000D9352858E@linuxmail.org>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Subject: Re: udev: what's up with old /dev ? 
Date: Mon, 11 Oct 2004 11:14:56 +0200
To: Hacksaw <hacksaw@hacksaw.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 11, 2004, at 01:15, Hacksaw wrote:

>> The very first thing init does is open /dev/console, and if it doesn't
>> exist the entire boot hangs.
>
> This raises a question: Would it be a useful thing to make a modified 
> init
> that could run udev before it does anything else?

FC3t2 boots from an "initrd" image that, among other things, mounts a 
tmpfs over "/dev" and creates "console", "null", "pts" and then 
proceeds to load "init".

