Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132877AbRAGQjP>; Sun, 7 Jan 2001 11:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135917AbRAGQi5>; Sun, 7 Jan 2001 11:38:57 -0500
Received: from hermes.mixx.net ([212.84.196.2]:33029 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S135493AbRAGQit>;
	Sun, 7 Jan 2001 11:38:49 -0500
Message-ID: <3A589AEE.C3447EDA@innominate.de>
Date: Sun, 07 Jan 2001 17:35:58 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: david <sector2@ihug.co.nz>, linux-kernel@vger.kernel.org
Subject: Re: file ops in kernel
In-Reply-To: <3A5803F2.EDA8055E@ihug.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

david wrote:
> 
> hi all
> 
> i now need to read a file from in the kernel 2.2.x
> dose any one know how to this ?

Look at open_exec and kernel_read, but also consider whether you could
solve your problem more elegantly with help from user space.  (This
should be in the FAQ.)

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
