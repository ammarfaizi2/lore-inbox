Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270264AbRHHCOp>; Tue, 7 Aug 2001 22:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270267AbRHHCOg>; Tue, 7 Aug 2001 22:14:36 -0400
Received: from blackhole.compendium-tech.com ([64.156.208.74]:24218 "EHLO
	sol.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S270264AbRHHCOT>; Tue, 7 Aug 2001 22:14:19 -0400
Date: Tue, 7 Aug 2001 19:13:50 -0700 (PDT)
From: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
X-X-Sender: <kernel@sol.compendium-tech.com>
To: Brian May <bam@snoopy.apana.org.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Encrypted Swap
In-Reply-To: <84zo9ci4dk.fsf@scrooge.chocbit.org.au>
Message-ID: <Pine.LNX.4.33.0108071907280.23797-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Aug 2001, Brian May wrote:

> Example: disk is faulty and will no longer work. How do you guarantee
> that nobody will be able to read it after you toss it out OR return it
> to the manufacturer to claim for warranty?

Most people paranoid with security (US DOD, NSA, etc.) have protocol
regarding disks with classified data on them: Once classified, always
classified. A failed disk still under warranty must forfiet that warranty
to ensure data integrity. If the disk is no longer useful (eg that 575MB
disk out of the SPARCstation 2 in the corner) then it is to be destroyed
with fire and the remains slagged.

> (of course, encrypting swap space is only part of the solution, here
> you need to encrypt everything).

Encrypting everything is what DISA decided they would do with the DII COE
operating environment for Windows NT and Solaris. DISA's solution under NT
was to zero the swapfile at system shutdown as well as use an encryption
scheme similar to what has been referred to earlier in this thread. The
solution under Solaris was to do encryption only. I'm not going to go into
detail about it, but basically, everything but the filesystems on-disk
have been encrypted. DII COE is not available for public consumption as
well as export outside the US. Besides, I pity anyone who's forced to use
it. It really is a miserable thing to be forced to use.

 Kelsey Hudson                                           khudson@ctica.com
 Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

