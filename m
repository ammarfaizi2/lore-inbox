Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbUDEBmk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 21:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262972AbUDEBmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 21:42:40 -0400
Received: from smtp2.world-net.co.nz ([203.96.119.37]:2061 "HELO
	mail.world-net.co.nz") by vger.kernel.org with SMTP id S262910AbUDEBmg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 21:42:36 -0400
Subject: Re: Kernel panic in 2.4.25
From: Matt Brown <matt@mattb.net.nz>
To: marcelo.tosatti@cyclades.com
Cc: kernel@linuxace.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org, dlstevens@ibm.com, davem@redhat.com
Content-Type: text/plain
Message-Id: <1081129354.1611.44.camel@argon.shr.crc.net.nz>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 05 Apr 2004 13:42:34 +1200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> IIRC a similar problem was in v2.6.
>
> I'll dig it up.

Was any progress made on this problem?

I am seeing the same panic as was originally reported using both kernel
2.4.25 and 2.4.26-rc1, I can easily reproduce it under the same
conditions as Hasso described in the original email. 

With quagga/ospfd running I simply execute
ifconfig eth0 down
ifconfig eth0 up 
in quick succession and a panic follows within 20 seconds. 

The panic does not occur if ospfd is not running, or if i pause for at
least 10 seconds between the two commands. 

Let me know if I can provide any more information that would be helpful
in solving this problem. 

Regards

-- 
Matt Brown
Email: matt@mattb.net.nz
GSM  : 021 611 544

