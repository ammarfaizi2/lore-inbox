Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277210AbRJINlY>; Tue, 9 Oct 2001 09:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277212AbRJINlO>; Tue, 9 Oct 2001 09:41:14 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:8720 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S277210AbRJINlD>; Tue, 9 Oct 2001 09:41:03 -0400
Date: Tue, 9 Oct 2001 15:41:34 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: proc file system
Message-ID: <20011009154134.C28423@artax.karlin.mff.cuni.cz>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <200110052202.f95M2Ig16051@mail.swissonline.ch> <20011006173025.F12624@arthur.ubicom.tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011006173025.F12624@arthur.ubicom.tudelft.nl>; from J.A.K.Mouw@ITS.TUDelft.NL on Sat, Oct 06, 2001 at 05:30:25PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Oct 06, 2001 at 12:02:18AM +0200, llx@swissonline.ch wrote:
> > i've written a prog interface for my logger utility to make it easy
> > to transport my logging information from kernel to userspace using
> > shell commands. now i want to use tail -f /prog/<mylogfile>. what
> > do i have to do for that to work. when using tail my loginfo gets
> > read form my ringbuffer, but nothing gets printed in the terminal.
> 
> I think you actually want a character device instead of a /proc file.

Could you please explain why? I can't see the advantage (read and write
are fileops; you can have them exactly the same for proc file and device).

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
