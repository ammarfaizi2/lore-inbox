Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262217AbTELPYA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 11:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTELPYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 11:24:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:55762 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262217AbTELPXZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 11:23:25 -0400
Message-ID: <3EBFBEF5.6050600@us.ibm.com>
Date: Mon, 12 May 2003 08:34:13 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: Re: 2.5.69-mjb1
References: <9380000.1052624649@[10.10.2.4]> <20030512132939.GF19053@holomorphy.com> <21850000.1052743254@[10.10.2.4]> <20030512150309.GG19053@holomorphy.com> <23510000.1052744845@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> OK, so maybe I'm still asleep, but I don't see why the hardcoded
> magic constant (grrr) is 4096 in mainline, when the stacksize is 8K.
> Presumably the 1019*4 makes up the rest of it? Maybe the real question 
> is what the hell was whoever wrote that in the first place smoking ? ;-)
> Why on earth would you skip halfway through the stack with one stupid 
> magic constant, and then the rest of the way with another? 

You can go ask the author:

http://linus.bkbits.net:8080/linux-2.5/diffs/include/asm-i386/processor.h@1.12?nav=index.html|src/|src/include|src/include/asm-i386|hist/include/asm-i386/processor.h


-- 
Dave Hansen
haveblue@us.ibm.com

