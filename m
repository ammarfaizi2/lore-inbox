Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132079AbRCVQwH>; Thu, 22 Mar 2001 11:52:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132101AbRCVQv6>; Thu, 22 Mar 2001 11:51:58 -0500
Received: from mail1.dexterus.com ([212.95.255.99]:42251 "EHLO
	mail1.dexterus.com") by vger.kernel.org with ESMTP
	id <S132079AbRCVQvm>; Thu, 22 Mar 2001 11:51:42 -0500
Message-ID: <3ABA2D61.41967C3D@dexterus.com>
Date: Thu, 22 Mar 2001 16:50:41 +0000
From: Vincent Sweeney <v.sweeney@dexterus.com>
Organization: Dexterus
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: More 2.4 memory usage wierdness?
In-Reply-To: <3AB9EDE3.E01A2AA8@dexterus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Sweeney wrote:
> 
> I have a question regarding a busy box I recently updated to
> '2.4.2-ac20'. It has been running for several hours without any real
> problems until I started getting 'dmesg' entries like:
> 
> Out of Memory: Killed process 30293 (httpd).
> Out of Memory: Killed process 32552 (mysqld).
> 
> Not a quick check with 'top' shows:
> 
> Mem:   771440K av,  396060K used,  375380K free,       0K shrd,    4972K
> buff
> Swap:  379416K av,  345000K used,   34416K free                  337128K
> cached
> 
> I have also attached my "/proc/meminfo" & "/proc/slabinfo" details.
> 
> Basically they all show the server has 370MB of free physical memory but
> its using lots of swap space and OOM is killing processes.
> 
> What gives?
> 
> Vince.

Maybe I should of also made it clear that is I run the same box with
2.2.18 I have no memory issues and swap is not used at all but when I
run with 2.4.2 I suddenly see my memory usage increase over 300MB and my
swap space maxes out.

-- 
Vincent Sweeney
System Architect
