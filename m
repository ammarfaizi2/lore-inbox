Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269817AbRHIOlZ>; Thu, 9 Aug 2001 10:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269819AbRHIOlP>; Thu, 9 Aug 2001 10:41:15 -0400
Received: from ffmdi5-212-144-149-114.arcor-ip.net ([212.144.149.114]:51700
	"EHLO merv") by vger.kernel.org with ESMTP id <S269817AbRHIOlJ>;
	Thu, 9 Aug 2001 10:41:09 -0400
Date: Thu, 9 Aug 2001 16:39:49 +0200
To: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>
Cc: imran.badr@cavium.com, linux-kernel@vger.kernel.org
Subject: Re: Exporting kernel memory to application
Message-ID: <20010809163949.B2854@bombe.modem.informatik.tu-muenchen.de>
Reply-To: Andreas Bombe <andreas.bombe@munich.netsurf.de>
Mail-Followup-To: Nitin Dhingra <nitin.dhingra@dcmtech.co.in>,
	imran.badr@cavium.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7FADCB99FC82D41199F9000629A85D1A01C650D2@dcmtechdom.dcmtech.co.in>
User-Agent: Mutt/1.3.18i
From: Andreas Bombe <andreas@bombe.modem.informatik.tu-muenchen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 08, 2001 at 03:48:50PM +0530, Nitin Dhingra wrote:
> You can do that by using kiobuf's ( only in kernel 2.4.x ).
> That way you could lock the user buffers in kernel but you 
> would have to allocate user buffer prior to using any kiobuf's functions 
> like map_user_kiobuf() 

When someone asks how to lock user buffers into kernel space they are
suggested to allocate the buffers in kernel and map them to user space
which is much cleaner, safer and everything.

That guy got it right on the first attempt.  Don't confuse him with
inferior solutions.

-- 
Andreas E. Bombe <andreas.bombe@munich.netsurf.de>    DSA key 0x04880A44
