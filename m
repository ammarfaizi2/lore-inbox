Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289175AbSAGLPA>; Mon, 7 Jan 2002 06:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289174AbSAGLOv>; Mon, 7 Jan 2002 06:14:51 -0500
Received: from mail.merconic.com ([62.96.220.180]:24764 "HELO
	mail.merconic.com") by vger.kernel.org with SMTP id <S289175AbSAGLOa>;
	Mon, 7 Jan 2002 06:14:30 -0500
Date: Mon, 7 Jan 2002 12:14:24 +0100
From: "marc. h." <heckmann@hbe.ca>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cerberus on 2.4.17-rc2 UP
Message-ID: <20020107121423.A4345@hbe.ca>
In-Reply-To: <20011220135904.B32516@hbe.ca> <Pine.LNX.4.21.0112211454140.7313-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0112211454140.7313-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Dec 21, 2001 at 02:56:34PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 02:56:34PM -0200, Marcelo Tosatti wrote:
> 
> Can you please run Cerberus again and give me more information ?

ok, I *finally* got it to deadlock again.. trick is to run 2 simultaneous
cerberus runs.. same symptoms, pings, can change VC's, hard drive light
constantly on but silent and no blinks. I had sysrq turned on this time (tested
before the run), but once deadlocked, doing Alt+SysRQ+8, Alt+SysRQ+T, etc would
print nothing at all.. 

-m

> 
> I want Alt+SysRQ+T, Alt+SysRQ+M and Alt+SysRQ+P output.
> 
> If those keys simply print the sysrq header, please try Alt+SysRQ+8 then
> the above again.
> 
> Thanks
> 
> On Thu, 20 Dec 2001, marc. h. wrote:
> 
> > I tried out the latest cerberus from
> > http://people.redhat.com/bmatthews/cerberus/ on a UP redhat-7.2 box. I ran the
> > standard non-destructive RedHat tests.
> > 
> > It ran for about 14 hours and then became unresponsive..  machine still ping'ed
> > , I could switch VC's scroll up on console, but that's it. Could not log in,
> > etc.. Another point is that the hard drive light remained on but it was not
> > seeking, it seemed dead silent.
> 

-- 
	C3C5 9226 3C03 CDF7 2EF1  029F 4CAD FBA4 F5ED 68EB
	key: http://people.hbesoftware.com/~heckmann/
