Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129060AbQKMQNy>; Mon, 13 Nov 2000 11:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129069AbQKMQNo>; Mon, 13 Nov 2000 11:13:44 -0500
Received: from devserv.devel.redhat.com ([207.175.42.156]:64528 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129060AbQKMQN2>; Mon, 13 Nov 2000 11:13:28 -0500
Date: Mon, 13 Nov 2000 11:13:19 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Steven_Snyder@3com.com, linux-kernel@vger.kernel.org
Subject: Re: State of Posix compliance in v2.2/v2.4 kernel?
Message-ID: <20001113111319.E1514@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <88256996.00577D9E.00@hqoutbound.ops.3com.com> <3A101009.5F05DA18@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A101009.5F05DA18@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Nov 13, 2000 at 11:00:09AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 11:00:09AM -0500, Jeff Garzik wrote:
> Steven_Snyder@3com.com wrote:
> > Sorry if this is a FAQ, but I've searched the archives for this list
> > (http://www.uwsg.iu.edu/hypermail/linux/kernel/) and only come with references
> > from 1996!
> > 
> > What is the state of Posix-compliant services (threads, semaphores, timers,
> > etc.) in the current (v2.2/v2.4) Linux kernels?
> 
> IMHO this is a question better asked of glibc people, not kernel people.
> 
> The kernel does its best to facilitate POSIX compliances,

Well, it does not do its best. There are several areas where kernel should
help, things like POSIX semaphores would be much faster with kernel support,
likewise threads if some things Ulrich stated here a couple of months
ago were done in the kernel, POSIX message queue passing is not doable in
userland without kernel help either (I have a message queue filesystem
kernel patch for this, but it is a 2.5 thing).

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
