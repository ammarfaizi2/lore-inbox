Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289049AbSAUFgQ>; Mon, 21 Jan 2002 00:36:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289050AbSAUFgH>; Mon, 21 Jan 2002 00:36:07 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:15377 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289049AbSAUFfx>; Mon, 21 Jan 2002 00:35:53 -0500
Date: Mon, 21 Jan 2002 00:35:52 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: performance of O_DIRECT on md/lvm
Message-ID: <20020121003552.A12850@redhat.com>
In-Reply-To: <200201181743.g0IHhO226012@street-vision.com.suse.lists.linux.kernel> <3C48607C.35D3DDFF@redhat.com.suse.lists.linux.kernel> <20020120201603.L21279@athlon.random.suse.lists.linux.kernel> <p734rlg90ga.fsf@oldwotan.suse.de> <20020121021224.O21279@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020121021224.O21279@athlon.random>; from andrea@suse.de on Mon, Jan 21, 2002 at 02:12:24AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 02:12:24AM +0100, Andrea Arcangeli wrote:
> yes, in short the API to allow the userspace to keep the I/O pipeline
> full with a ring of user buffers is not available at the moment.

See http://www.kvack.org/~blah/aio/ .  Seems to work pretty nicely 
for raw io.

		-ben
