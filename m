Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130848AbQKNIhv>; Tue, 14 Nov 2000 03:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130891AbQKNIhl>; Tue, 14 Nov 2000 03:37:41 -0500
Received: from dillweed.dsl.xmission.com ([166.70.14.212]:31314 "HELO
	winder.codepoet.org") by vger.kernel.org with SMTP
	id <S130848AbQKNIha>; Tue, 14 Nov 2000 03:37:30 -0500
Date: Tue, 14 Nov 2000 01:13:32 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Q: Linux rebooting directly into linux.
Message-ID: <20001114011331.B1496@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: "Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <m17l6deey7.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Thu, Nov 09, 2000 at 01:18:24AM -0700
X-Operating-System: Linux 2.2.17, Rebel-NetWinder(Intel sa110 rev 3), 262.14 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Nov 09, 2000 at 01:18:24AM -0700, Eric W. Biederman wrote:
> 
> I have recently developed a patch that allows linux to directly boot
> into another linux kernel.  

Looks very cool.  I'm curious about your decision to use ELF images.  This
makes it much less conveinient to use due to the kernel postprocessing, and
makes it that the kernel binary from which you initially boot is not
necessirily the same as the binary that you re-boot into.  

Wouldn't it be more reasonable to simply try to exec whatever file is provided?
If the concern is initrds; they can be simply pasted into the kernel binary.

 -Erik

--
Erik B. Andersen   email:  andersee@debian.org
--This message was written using 73% post-consumer electrons--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
