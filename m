Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267937AbRHJNJN>; Fri, 10 Aug 2001 09:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267923AbRHJNJD>; Fri, 10 Aug 2001 09:09:03 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:53263 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S267911AbRHJNIu>; Fri, 10 Aug 2001 09:08:50 -0400
Date: Fri, 10 Aug 2001 15:09:01 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 reproducable oops through Tivoli BA client 3.7.2.0
Message-ID: <20010810150901.A30330@krusty.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010810143637.B31349@emma1.>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010810143637.B31349@emma1.>; from matthias.andree@stud.uni-dortmund.de on Fri, Aug 10, 2001 at 14:36:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Matthias Andree wrote:

> This morning, one of our machines Oopsed while running dsmc (Tivoli
> storage manager Backup-Archive client 3.7.2.0), dsmc itself caught
> SIGSEGV:
> 
> 08/10/2001 03:15:54 B/A Performance thread, fatal error, signal 11
> 
> This is somewhat peculiar since it should not be possible for a
> user-space process to shoot a kernel process, and it's even more
> peculiar because it breaks our daily backup.
> 
> Assistance is sought.

I tried stracing that beast (strace V4.2), but I failed, I only trace the
"Performance" thread which displays the dsmc progress. Is there any way
to trace one of the remaining two threads so I can figure which file or
directory the dsmc dies on? 
