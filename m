Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVCVN5G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVCVN5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbVCVN5G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:57:06 -0500
Received: from spectre.fbab.net ([212.214.165.139]:49836 "HELO mail2.fbab.net")
	by vger.kernel.org with SMTP id S261228AbVCVN5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:57:03 -0500
Message-ID: <42402428.8040506@fbab.net>
Date: Tue, 22 Mar 2005 14:56:56 +0100
From: "Magnus Naeslund(t)" <mag@fbab.net>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: paulmck@us.ibm.com
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc1-V0.7.41-01
References: <20050319191658.GA5921@elte.hu> <20050320174508.GA3902@us.ibm.com> <20050321085332.GA7163@elte.hu> <20050321090122.GA8066@elte.hu> <20050321090622.GA8430@elte.hu> <423F5456.5010908@fbab.net> <20050322054025.GA1296@us.ibm.com>
In-Reply-To: <20050322054025.GA1296@us.ibm.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> 
> Hello, Magnus,
> 
> I believe that my earlier patch might take care of this (included again
> for convenience).
> 
> 						Thanx, Paul
> 

I just tested this patch, and it did not solve my problem.
The dst cache still grows to the maximum and starts spitting errors via 
printk.

I'll do a make mrproper build too to make sure I didn't make any mistakes.

Regards,
Magnus
