Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287002AbSAUOkj>; Mon, 21 Jan 2002 09:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286712AbSAUOka>; Mon, 21 Jan 2002 09:40:30 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:11624 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287002AbSAUOkY>; Mon, 21 Jan 2002 09:40:24 -0500
Date: Mon, 21 Jan 2002 15:41:25 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
Message-ID: <20020121154125.A8292@athlon.random>
In-Reply-To: <200201181743.g0IHhO226012@street-vision.com.suse.lists.linux.kernel> <3C48607C.35D3DDFF@redhat.com.suse.lists.linux.kernel> <20020120201603.L21279@athlon.random.suse.lists.linux.kernel> <p734rlg90ga.fsf@oldwotan.suse.de> <20020121021224.O21279@athlon.random> <20020121003552.A12850@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20020121003552.A12850@redhat.com>; from bcrl@redhat.com on Mon, Jan 21, 2002 at 12:35:52AM -0500
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 12:35:52AM -0500, Benjamin LaHaise wrote:
> On Mon, Jan 21, 2002 at 02:12:24AM +0100, Andrea Arcangeli wrote:
> > yes, in short the API to allow the userspace to keep the I/O pipeline
> > full with a ring of user buffers is not available at the moment.
> 
> See http://www.kvack.org/~blah/aio/ .  Seems to work pretty nicely 
> for raw io.

of course async-io API is the right fix to keep the I/O pipeline always
full. Thanks for pointing it out.

Andrea
