Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283052AbRK1ONc>; Wed, 28 Nov 2001 09:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283066AbRK1OMs>; Wed, 28 Nov 2001 09:12:48 -0500
Received: from w089.z209220022.nyc-ny.dsl.cnc.net ([209.220.22.89]:60686 "HELO
	yucs.org") by vger.kernel.org with SMTP id <S283062AbRK1OLA>;
	Wed, 28 Nov 2001 09:11:00 -0500
Subject: Re: task_struct.mm == NULL
From: Shaya Potter <spotter@cs.columbia.edu>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <p734rnfrsnb.fsf@amdsim2.suse.de>
In-Reply-To: <Pine.GSO.4.31.0111281300070.8642-100000@eduserv.rug.ac.be.suse.lists.linux.
	kernel>  <p734rnfrsnb.fsf@amdsim2.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 09:10:30 -0500
Message-Id: <1006956633.4222.2.camel@zaphod>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 07:23, Andi Kleen wrote:
> Frank Cornelis <Frank.Cornelis@rug.ac.be> writes:
> 
> > Hey,
> > 
> > I found in some code checks for task_struct.mm being NULL.
> > When can task_struct.mm of a process be NULL except right before the
> > process-kill?
> 
> For kernel threads that run in lazy-mm mode. It allows a much cheaper context
> switch into kernel threads.

oh. so not all kernel threades have mm == null.  I used to think that
kernel threads ran in the kernel's address space, therefore there was no
point in having an mm struct as that just defines a virtual process
address space.  What's this lazy_mm mode?

thanks,

shaya

