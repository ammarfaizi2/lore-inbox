Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317267AbSFHBzW>; Fri, 7 Jun 2002 21:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317375AbSFHBzV>; Fri, 7 Jun 2002 21:55:21 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:8711 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317267AbSFHBzV>;
	Fri, 7 Jun 2002 21:55:21 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Hotplug CPU Boot Changes: BEWARE 
In-Reply-To: Your message of "07 Jun 2002 08:51:32 CST."
             <m1elfjw39n.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Jun 2002 11:55:09 +1000
Message-ID: <18628.1023501309@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07 Jun 2002 08:51:32 -0600, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>Thinking in terms of physically hot-plugging cpus has me doubt the
>actual utility of this code.  Instead thinking of dynamically enabling
>and disabling processors for debugging sounds very reasonable.

IBM (S390) and SGI hardware.  Virtually disable the cpu so the cpu
partition manager migrates work off the cpu[*].  Vary the cpu offline.
Physically replace the cpu.  Reverse the process.  It all works fine if
the hardware supports it and[*] the OS supports migration off a cpu.

