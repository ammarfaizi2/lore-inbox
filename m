Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUAKNwG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 08:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265137AbUAKNwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 08:52:06 -0500
Received: from lapd.cj.edu.ro ([193.231.142.101]:31881 "HELO lapd.cj.edu.ro")
	by vger.kernel.org with SMTP id S264537AbUAKNwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 08:52:03 -0500
Date: 11 Jan 2004 15:52:01 +0200
Date: Sun, 11 Jan 2004 15:52:01 +0200 (EET)
From: "Cosmin Matei \(lkml\)" <linux@lapd.cj.edu.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.24-pre3 and ip_gre module ...
In-Reply-To: <Pine.LNX.4.51L0.0401031512090.2488@lapd.cj.edu.ro>
Message-ID: <Pine.LNX.4.51L0.0401111548450.29249@lapd.cj.edu.ro>
References: <Pine.LNX.4.51L0.0401031512090.2488@lapd.cj.edu.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Jan 2004, Cosmin Matei (lkml) wrote:

> Hi,
> 
> I'm trying to use the new kernel 2.4.23 + 2.4.24-pre3 patch and the first 
> impression is very good. Just one problem appears to make me to reconsider 
> using 2.4.24-pre3: ip_gre module it's not working!!! The module is 
> loading, the interface it's bringing up but no packets pass thru ... what 
> can I do? There is any modifications from 2.4.21-rc6?

I've testing again with 2.4.25-pre4 and I found the same problem. Now I'm 
sure that the problem is not in the ip_gre module ... my network is not 
respounding when I loaded my QoS script (working with cbq and sfq). With 
htb everything it's working just fine. What's the problem with sch_cbq or 
sch_sfq?

Thank you again,
Cosmin
