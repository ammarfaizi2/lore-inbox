Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273895AbRI0Uwh>; Thu, 27 Sep 2001 16:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273896AbRI0Uw1>; Thu, 27 Sep 2001 16:52:27 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:9877 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S273895AbRI0UwM>;
	Thu, 27 Sep 2001 16:52:12 -0400
Date: Thu, 27 Sep 2001 21:52:35 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Jesper Juhl <juhl@eisenstein.dk>,
        Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: OOM killer
Message-ID: <1123696067.1001627554@[195.224.237.69]>
In-Reply-To: <3BB20C27.4125F9BA@eisenstein.dk>
In-Reply-To: <3BB20C27.4125F9BA@eisenstein.dk>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On Wednesday, 26 September, 2001 7:11 PM +0200 Jesper Juhl 
<juhl@eisenstein.dk> wrote:

> Or maybe make it a configure option if Linux should over commit memory or
> not.

deja vu

shed:~# cat /proc/sys/vm/overcommit_memory
0
shed:~# echo 1 >/proc/sys/vm/overcommit_memory
shed:~# cat /proc/sys/vm/overcommit_memory
1
shed:~# echo 0 >/proc/sys/vm/overcommit_memory
shed:~# cat /proc/sys/vm/overcommit_memory
0

--
Alex Bligh
