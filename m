Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273389AbRINSiA>; Fri, 14 Sep 2001 14:38:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273445AbRINShv>; Fri, 14 Sep 2001 14:37:51 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:25106 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273389AbRINShr>; Fri, 14 Sep 2001 14:37:47 -0400
Message-ID: <3BA24E85.C92FA693@zip.com.au>
Date: Fri, 14 Sep 2001 11:37:57 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Matthias Haase <matthias_haase@bennewitz.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: repeatable SMP lockups - kernel 2.4.9
In-Reply-To: <20010914143021.0a5c9791.matthias_haase@bennewitz.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Haase wrote:
> 
> Our new SMP file- and printserver locks always hard up, if higher load
> come on the NIC. True stable without networking (X11, DRI
> 

Have you tried enabling the NMI watchdog?  Boot with the

	nmi_watchdog=1

LILO option.
