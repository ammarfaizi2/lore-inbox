Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289507AbSAONrU>; Tue, 15 Jan 2002 08:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289549AbSAONrJ>; Tue, 15 Jan 2002 08:47:09 -0500
Received: from ns.ithnet.com ([217.64.64.10]:29708 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289507AbSAONrA>;
	Tue, 15 Jan 2002 08:47:00 -0500
Date: Tue, 15 Jan 2002 14:46:52 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problem with bttv driver
Message-Id: <20020115144652.46d9ee18.skraw@ithnet.com>
In-Reply-To: <20020115142017.D8191@bytesex.org>
In-Reply-To: <20020114210039.180c0438.skraw@ithnet.com>
	<E16QETz-0002yD-00@the-village.bc.nu>
	<20020115004205.A12407@werewolf.able.es>
	<slrna480cv.68d.kraxel@bytesex.org>
	<20020115121424.10bb89b2.skraw@ithnet.com>
	<20020115142017.D8191@bytesex.org>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 14:20:17 +0100
Gerd Knorr <kraxel@bytesex.org> wrote:

> On Tue, Jan 15, 2002 at 12:14:24PM +0100, Stephan von Krawczynski wrote:
> > On 15 Jan 2002 10:17:03 GMT
> > Gerd Knorr <kraxel@bytesex.org> wrote:
> > 
> > > MM wise it shouldn't make a difference whenever you are using 0.7.83 or
> > > 0.7.88 (I've mailed 0.7.88 patches to macelo for 2.4.18 btw).  The 0.8.x
> > > versions have a complete different way to do the memory management.
> > 
> > No vmallocs?
> 
> Yes.  Instead of remapping vmalloced kernel memory it gives you shared
> anonymous pages, then does zerocopy DMA using kiobufs.  You may run in
> trouble with >4GB machines.

Interesting.
What's the problem on > 4GB ?

Regards,
Stephan

