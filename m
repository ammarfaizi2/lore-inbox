Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314798AbSDVV2K>; Mon, 22 Apr 2002 17:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314799AbSDVV2J>; Mon, 22 Apr 2002 17:28:09 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14229 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314798AbSDVV2G>;
	Mon, 22 Apr 2002 17:28:06 -0400
Date: Mon, 22 Apr 2002 15:25:37 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>, Alexander Viro <viro@math.psu.edu>
cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: locking in sync_old_buffers
Message-ID: <8900000.1019514337@flay>
In-Reply-To: <3CC47A27.4000803@us.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   0.09%  8.1% 4598us(9648us)  105us( 231us)(0.00%)        37 91.9%  8.1%     0%    sync_old_buffers+0x1c

16-way NUMA-Q kernel compile:

0.64% 20.0%   38ms(  54ms)   93us(  93us)(0.00%)         5 80.0% 20.0%    0%
sync_old_buffers+0x20

Hold times - ouch. 

M.

