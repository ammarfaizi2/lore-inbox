Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280588AbRL0DFM>; Wed, 26 Dec 2001 22:05:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285073AbRL0DFE>; Wed, 26 Dec 2001 22:05:04 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:28686 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S280588AbRL0DE5>;
	Wed, 26 Dec 2001 22:04:57 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: axboe@suse.de, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BUG and Kernel Panic on 2.5.2-pre1 with loop and cdrom 
In-Reply-To: Your message of "Wed, 26 Dec 2001 20:33:07 +0200."
             <Pine.LNX.4.33.0112262029370.28333-100000@netfinity.realnet.co.sz> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Dec 2001 14:04:44 +1100
Message-ID: <11207.1009422284@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Dec 2001 20:33:07 +0200 (SAST), 
Zwane Mwaikambo <zwane@linux.realnet.co.sz> wrote:
>eip: cc916780 <== is this because we're in an interrupt handler?

Probably because your module structure after reboot is not the same as
the panic.  Try using the module data saved in /var/log/ksymoops, man
insmod and look for ksymoops assistance.

