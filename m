Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293720AbSCPF67>; Sat, 16 Mar 2002 00:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293722AbSCPF6t>; Sat, 16 Mar 2002 00:58:49 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:44806 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S293720AbSCPF6g>;
	Sat, 16 Mar 2002 00:58:36 -0500
Date: Fri, 15 Mar 2002 21:58:33 -0800
From: Greg KH <greg@kroah.com>
To: Gordon J Lee <gordonl@world.std.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IBM x360 2.2.x boot failure, 2.4.9 works fine
Message-ID: <20020316055833.GB8125@kroah.com>
In-Reply-To: <3C927F3E.7C7FB075@world.std.com> <20020315233441.GG5563@kroah.com> <3C92A4EB.C50ED834@world.std.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C92A4EB.C50ED834@world.std.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sat, 16 Feb 2002 03:54:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 08:50:35PM -0500, Gordon J Lee wrote:
> 
> > Eeek, these machines are now in the wild?  Didn't realize this :)
> 
> Yes.  They are still ramping up production, and evals are scarce.
> I am pretty excited about it, because on paper, even without
> the hyperthreading, they should run pretty fast for I/O intensive
> workloads.  My current eval project is to get some empirical
> performance numbers on a particular application.

Great, it will be nice to see some real world use of these machines to
see how well the HyperThreading works out.

> As a matter of fact, we did try a UP 2.2.x kernel, and it worked.  But then
> we only have one CPU, and where is the fun in that ?  :-)
> So I suppose this gives further support to the mishandled APIC table
> theory.

Yes it does, thanks for testing this.

> I am interested and motivated to understand the details of APIC's further.
> If I were to attempt to patch up a 2.2.x kernel to workaround this problem,
> 
> what documentation should I have on hand ?  I have an Intel SMP 1.4
> doc, although I haven't studied it in detail yet.  Is this sufficient or
> are there other Must Have documents that I will need ?

James would be the best person for this, as he got this machine up and
working on Linux properly.

thanks,

greg k-h
