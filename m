Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268005AbRGVRec>; Sun, 22 Jul 2001 13:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268006AbRGVReX>; Sun, 22 Jul 2001 13:34:23 -0400
Received: from [209.250.58.234] ([209.250.58.234]:47626 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S268005AbRGVReD>; Sun, 22 Jul 2001 13:34:03 -0400
Date: Sun, 22 Jul 2001 12:33:59 -0500
From: Steven Walter <srwalter@yahoo.com>
To: jneeraj@in.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Binding thread to a processor
Message-ID: <20010722123359.A23254@hapablap.dyn.dhs.org>
In-Reply-To: <CA256A91.003EA998.00@d73mta01.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <CA256A91.003EA998.00@d73mta01.au.ibm.com>; from jneeraj@in.ibm.com on Sun, Jul 22, 2001 at 04:52:37PM +0530
X-Uptime: 12:27pm  up 1 day, 16:09,  0 users,  load average: 1.15, 1.08, 1.06
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 04:52:37PM +0530, jneeraj@in.ibm.com wrote:
> Hi all,
>      I am using Suse-linux-7.1 with default linux -ppc kernel on apple G4
> machine.
> 
> I have a multithreaded user application and I need to run it on an
> 2.4.2-SMP machine. Do I need bind the thread to a particular processor? If
> yes, how do I do that?
> 
> ---
> Neeraj Jain

You shouldn't need to take any special action to get the threads to run
on seperate processes, if that's what you're asking.

If you want the threads to only run on a specific processor each, I'm
afraid that is functionality that isn't availible in the default linux
kernel.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
