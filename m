Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSFYVqn>; Tue, 25 Jun 2002 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSFYVqm>; Tue, 25 Jun 2002 17:46:42 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:20392 "EHLO
	zcars04f.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315941AbSFYVqk>; Tue, 25 Jun 2002 17:46:40 -0400
Message-ID: <3D18E4B9.56DAAC9E@nortelnetworks.com>
Date: Tue, 25 Jun 2002 17:46:33 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux Kernel
References: <3D18A26A.73E6DD07@zip.com.au> from "Andrew Morton" at Jun 25, 2 09:15:01 pm <200206251743.VAA00510@sex.inr.ac.ru> <3D18C8C8.D35FF1A3@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> I wrote a little app to test this - it times a couple of copy algorithms
> at all possible alignments.  It may be useful for someone...  http://www.zip.com.au/~akpm/linux/cptimer.tar.gz
> I think it covers everything - uncached/cache source/dest,
> all possible transfer alignemnts.

I have a problem.

[cfriesen@pcard0ks cptimer]$ ./report.sh 
vendor_id       : GenuineIntel
model name      : Pentium III (Katmai)
stepping        : 3
cpu MHz         : 548.633
cache size      : 512 KB


CP_OPTS= ./all-alignments.sh
expr: syntax error
expr: syntax error
expr: syntax error
expr: syntax error
expr: syntax error
expr: non-numeric argument
expr: syntax error
expr: non-numeric argument
expr: syntax error
expr: syntax error


Any ideas?

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
