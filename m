Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288981AbSBKNHY>; Mon, 11 Feb 2002 08:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288985AbSBKNHO>; Mon, 11 Feb 2002 08:07:14 -0500
Received: from angband.namesys.com ([212.16.7.85]:34432 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S288981AbSBKNHF>; Mon, 11 Feb 2002 08:07:05 -0500
Date: Mon, 11 Feb 2002 16:06:58 +0300
From: Oleg Drokin <green@namesys.com>
To: Andreas Happe <andreashappe@subdimension.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: boot problems using 2.5.3-dj3 || -dj4
Message-ID: <20020211160658.A7863@namesys.com>
In-Reply-To: <000c01c1b0bf$567ab910$704e2e3e@angband> <20020208180216.H32413@suse.de> <00c301c1b0d7$d1f07ae0$4e492e3e@angband>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c301c1b0d7$d1f07ae0$4e492e3e@angband>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Feb 08, 2002 at 08:34:41PM +0100, Andreas Happe wrote:
> >  > sorry, with dj4 modprobe dies with the error message
> >  > "PAP-14030: direct2indirect: posted or inserted byte exists in the
> >  > treeinvalid operand: 0000"
> >  Ok, that's one for Oleg & Co to take a look at.
> >  Can you run the oops dump through ksymoops ?
> the error occurs in  ./fs/reiserfs/tail-conversion.c .
> the kernel oops jumped to another position by now, but it is still the same
> error message. I'm using a reiserfs root position.
Can you please decode the oops you provided.
Also can you run reiserfsck on your partition and give us the log file?
Thank you. (you may need to boot off rescue CD or something to
be able to run reiserfsck on root partition).

Bye,
    Oleg
