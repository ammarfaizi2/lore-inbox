Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135899AbREIIby>; Wed, 9 May 2001 04:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135900AbREIIbp>; Wed, 9 May 2001 04:31:45 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:28435 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S135899AbREIIbd>; Wed, 9 May 2001 04:31:33 -0400
Date: Wed, 9 May 2001 10:27:46 +0200
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Sean Jones <sjones@ossm.edu>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SPARC include problem
Message-ID: <20010509102746.D1802@arthur.ubicom.tudelft.nl>
In-Reply-To: <3AF71B1F.56FFCA16@ossm.edu> <20010508120108.A1802@arthur.ubicom.tudelft.nl> <3AF8B6CF.94EF38D@ossm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3AF8B6CF.94EF38D@ossm.edu>; from sjones@ossm.edu on Tue, May 08, 2001 at 10:17:35PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2001 at 10:17:35PM -0500, Sean Jones wrote:
> The include error was in kernel/sched.c . Should I rewrite the includes
> for this file to include include/asm/irq.h over include/linux/irq.h? I
> temporarily bypassed this problem by creating a blank asm/hw_irq.h . 

You shouldn't expect to be able to compile the main kernel source on
Sparc at all. See http://www.tux.org/lkml/#s6-6 .


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
