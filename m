Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310479AbSCPRfD>; Sat, 16 Mar 2002 12:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310480AbSCPRey>; Sat, 16 Mar 2002 12:34:54 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:51975 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S310479AbSCPRen>;
	Sat, 16 Mar 2002 12:34:43 -0500
Date: Sat, 16 Mar 2002 09:34:34 -0800
From: Greg KH <greg@kroah.com>
To: Gordon J Lee <gordonl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020316173434.GB10003@kroah.com>
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315234333.GH5563@kroah.com> <3C92B1EA.F40BDBD5@world.std.com> <20020316055542.GA8125@kroah.com> <3C938093.D1640CB6@world.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C938093.D1640CB6@world.std.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 16 Feb 2002 15:28:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 12:27:48PM -0500, Gordon J Lee wrote:
> > > > > 2.4.9     works fine!
> > > >
> > > > Forgot to mention, how many processors does this kernel show you having?
> > >
> > > It has two physical packages, and shows two processors.  See below.
> >
> > Ah, can you try the latest 2.4.19-ac tree and make sure that the rest of
> > your processors (the "evil" twins) show up?
> 
> Yes, they show up.  I tried 'cat /proc/cpuinfo' on the following:
> 
> 2.4.18  shows two processors
> 2.4.19-pre3 shows two processors
> 2.4.19-pre3-ac1 shows four processors

Great, thanks for testing.  I'd recommend using this hardware :)

greg k-h
