Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263486AbUAWX3K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 18:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266755AbUAWX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 18:29:10 -0500
Received: from smtp09.auna.com ([62.81.186.19]:8393 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S263486AbUAWX3I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 18:29:08 -0500
Date: Sat, 24 Jan 2004 00:29:06 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2-rc1-mm2
Message-ID: <20040123232906.GA4528@werewolf.able.es>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040123013740.58a6c1f9.akpm@osdl.org> (from akpm@osdl.org on Fri, Jan 23, 2004 at 10:37:40 +0100)
X-Mailer: Balsa 2.0.16
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 01.23, Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.2-rc1/2.6.2-rc1-mm2/
> 
> 

Still have to try with -mm2, but with mm1, my i2c temp sensors are scaled by 10 !!
It is fun to read my processor runs at 400 ºC ;)

werewolf:/sys/bus/i2c/devices/1-0290# sensors -v
sensors version 2.8.2
werewolf:/sys/bus/i2c/devices/1-0290# cat temp_input1
38000
werewolf:/sys/bus/i2c/devices/1-0290# cat temp_input2
40000

??

-- 
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrake Linux release 10.0 (Cooker) for i586
Linux 2.6.2-rc1-jam1 (gcc 3.3.2 (Mandrake Linux 10.0 3.3.2-4mdk))
