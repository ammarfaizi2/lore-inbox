Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132989AbRAJO4G>; Wed, 10 Jan 2001 09:56:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135215AbRAJOz4>; Wed, 10 Jan 2001 09:55:56 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6786 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S132989AbRAJOzr>;
	Wed, 10 Jan 2001 09:55:47 -0500
Date: Wed, 10 Jan 2001 06:38:35 -0800
Message-Id: <200101101438.GAA02263@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: antirez@invece.org
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20010110174859.R7498@prosa.it> (message from antirez on Wed, 10
	Jan 2001 17:48:59 +0100)
Subject: Re: * 4 converted to << 2 for networking code
In-Reply-To: <20010110174859.R7498@prosa.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: 	Wed, 10 Jan 2001 17:48:59 +0100
   From: antirez <antirez@invece.org>

   The attached patch converts many occurences of '* 4' in the
   networking code (often used to convert in bytes the TCP data offset
   and the IP header len) to the faster '<< 2'.

The compiler does this for you, check the assembler it outputs.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
