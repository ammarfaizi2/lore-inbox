Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280676AbRKFWyI>; Tue, 6 Nov 2001 17:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280669AbRKFWxw>; Tue, 6 Nov 2001 17:53:52 -0500
Received: from codepoet.org ([166.70.14.212]:24363 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280665AbRKFWwc>;
	Tue, 6 Nov 2001 17:52:32 -0500
Date: Tue, 6 Nov 2001 15:52:33 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011106155233.A32343@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20011106154240.A32249@codepoet.org> <Pine.LNX.4.33.0111061450530.22170-100000@segfault.osdlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111061450530.22170-100000@segfault.osdlab.org>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 06, 2001 at 02:53:27PM -0800, Patrick Mochel wrote:
> How about
> 
> $ cat /proc/cpus/0
> 
> PROCESSOR=0
> VENDOR_ID=GenuineIntel
> CPU_FAMILY=6
> MODEL=6
> MODEL_NAME="Celeron (Mendocino)"
> .....
> 
> $ for i in `ls /proc/cpus/` ; do
> 	cat $i
>   done
> ...

much better.  

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
