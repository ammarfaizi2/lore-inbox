Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277746AbRJ3UTa>; Tue, 30 Oct 2001 15:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277756AbRJ3UTV>; Tue, 30 Oct 2001 15:19:21 -0500
Received: from firebird.planetinternet.be ([195.95.34.5]:29195 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S277746AbRJ3UTR>; Tue, 30 Oct 2001 15:19:17 -0500
Date: Tue, 30 Oct 2001 21:19:12 +0100
From: Kurt Roeckx <Q@ping.be>
To: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
Cc: Johan <jo_ni@telia.com>, linux-kernel@vger.kernel.org
Subject: Re: Still having problems with eepro100
Message-ID: <20011030211912.A192@ping.be>
In-Reply-To: <20011030123927.74e26501.jo_ni@telia.com> <20011030125720.A469@stud.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011030125720.A469@stud.ntnu.no>; from tlan@stud.ntnu.no on Tue, Oct 30, 2001 at 12:57:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2001 at 12:57:20PM +0100, Thomas Langås wrote:
> I'm experiensing the:
> eth0: Card reports no resources
> 
> And, then a hang of at least a minute before the network connection is
> restored. All my connections are 100Mbit full duplex, and the error comes
> when doing heavy traffic. (Try bonnie++ over NFS, for instance).

I used to have this problem too.  Whenever I downloaded something
at high speed, I got that error.

This was with an older 2.4 kernel (2.4.5 I think), and the
previous harddisk which died on me.  Now with 2.4.8 I don't have
the problem anymore.  I assumed it had to do with the other disk
being slow, I think it was still doing PIO.  Maybe it's some
other thing which causes the kernel not being able to react fast
enough?


Kurt

