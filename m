Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131874AbRCXXcv>; Sat, 24 Mar 2001 18:32:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131877AbRCXXcl>; Sat, 24 Mar 2001 18:32:41 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:31748 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131874AbRCXXc0>;
	Sat, 24 Mar 2001 18:32:26 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andr Dahlqvist <anedah-9@student.luth.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: MD5 check failes for ISDN related files on 2.4.2-ac24 
In-Reply-To: Your message of "Sat, 24 Mar 2001 14:43:34 BST."
             <200103241343.f2ODhYF14378@gepetto.dc.luth.se> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 Mar 2001 09:31:39 +1000
Message-ID: <32680.985476699@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Mar 2001 14:43:34 +0100 (MET), 
Andr Dahlqvist <anedah-9@student.luth.se> wrote:
>I spotted these messages during 'make dep' on
>2.4.2-ac24:
>
>make -C hisax fastdep
>md5sum: MD5 check failed for 'isac.c'
>They all seam to be related to the ISDN code. Is this
>something to worry about?

No, the code should not be executed during make dep but nobody cares
enought about the problem to fix it.

