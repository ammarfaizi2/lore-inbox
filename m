Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135783AbRDTCkX>; Thu, 19 Apr 2001 22:40:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135784AbRDTCkN>; Thu, 19 Apr 2001 22:40:13 -0400
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:32433 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135783AbRDTCkA>; Thu, 19 Apr 2001 22:40:00 -0400
Date: Thu, 19 Apr 2001 22:38:50 -0400
From: Bill Nottingham <notting@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ac10 ide-cd oopses on boot
Message-ID: <20010419223850.A2177@nostromo.devel.redhat.com>
Mail-Followup-To: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010420004914.A1052@werewolf.able.es> <E14qNWF-0008Jc-00@the-village.bc.nu> <20010420013429.A1054@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010420013429.A1054@werewolf.able.es>; from jamagallon@able.es on Fri, Apr 20, 2001 at 01:34:29AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J . A . Magallon (jamagallon@able.es) said: 
> > Can you back out the ide-cd changes Jens did and see if that fixes it ?
> 
> Reverted the changes in ide-cd.[hc], and same result.

You want to back out the stuff from drivers/cdrom/cdrom.c; I backed
out the parts of the patch new there to ac10, and it worked again
for me...

Bill
