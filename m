Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbVINDpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbVINDpU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 23:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVINDpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 23:45:20 -0400
Received: from smtpout.mac.com ([17.250.248.70]:15814 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932583AbVINDpT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 23:45:19 -0400
In-Reply-To: <432705A0.1070407@spamtest.viacore.net>
References: <4325F3D5.9040109@spamtest.viacore.net> <20050912.144107.37064900.davem@davemloft.net> <4325FADB.4090804@spamtest.viacore.net> <20050912.151230.100651236.davem@davemloft.net> <43260A8D.1090508@spamtest.viacore.net> <20050913165228.GG28578@csclub.uwaterloo.ca> <432705A0.1070407@spamtest.viacore.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5A770DA0-A30F-45B1-A47A-2FD21714FA3C@mac.com>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Pure 64 bootloaders
Date: Tue, 13 Sep 2005 23:44:55 -0400
To: Joe Bob Spamtest <joebob@spamtest.viacore.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 13, 2005, at 13:00:16, Joe Bob Spamtest wrote:
>> Is the alpha also pure 64bit?
>
> Alpha was designed 64-bit from the start. DEC did a lot of neat  
> things with the design of that processor -- it's a shame it went  
> the way of the dodo when ia64 was proposed.

PowerPC was designed 64-bit from the start too!  It's just that the  
architecture design group also realized that there would be a demand  
for 32-bit CPUs, and so from the _64-bit_ system, they designed a 32- 
bit system whose entire instruction set would be forward-compatible  
to 64-bit systems when they came out.  That's why 32-bit PowerPC  
machine code and 64-bit PowerPC machine code are completely identical  
except that 64-bit CPUs also have a few opcodes to process 64-bit  
data and a few extra kernel-mode registers.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at people who weren't supposed to be in your machine room.
   -- Anthony de Boer


