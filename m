Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262768AbSIUSLg>; Sat, 21 Sep 2002 14:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275931AbSIUSLg>; Sat, 21 Sep 2002 14:11:36 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:60174 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262768AbSIUSLf>;
	Sat, 21 Sep 2002 14:11:35 -0400
Date: Sat, 21 Sep 2002 11:16:12 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux-kernel@vger.kernel.org,
       hardeneddrivers-discuss@lists.sourceforge.net,
       cgl_discussion@lists.osdl.org
Subject: Re: my review of the Device Driver Hardening Design Spec
Message-ID: <20020921181611.GA28315@kroah.com>
References: <mailman.1032587460.6299.linux-kernel2news@redhat.com> <200209211251.g8LCpFt23725@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209211251.g8LCpFt23725@devserv.devel.redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 21, 2002 at 08:51:15AM -0400, Pete Zaitcev wrote:
> 
> > In summary, I think that a lot of people have spent a lot of time in
> > creating this document, and the surrounding code that matches this
> > document.  I really wish that a tiny bit of that effort had gone into
> > contacting the Linux kernel development community, and asking to work
> > with them on a project like this.  Due to that not happening, and by
> > looking at the resultant spec and code, I'm really afraid the majority
> > of that time and effort will have been wasted.
> 
> Eek. They never mentioned any code before now. In fact they
> explicitly said they weren't going to code before the spec
> was ready.

Oh, there's lots of code:
	A "hardened" binary kernel driver:
		http://unc.dl.sourceforge.net/sourceforge/hardeneddrivers/sampledriver-0.1-1.i386.rpm
	(um people, why a binary?  Where's the source for this?)

	Some header files:
		http://unc.dl.sourceforge.net/sourceforge/hardeneddrivers/ddhardening_headerfiles.tar.gz

	A bunch of diagnostics code:
		http://linux-diag.sourceforge.net/code/cpu_affinity-v0.2.1.tar.gz
		http://linux-diag.sourceforge.net/code/pmem-0.2.1.tar.gz
		http://linux-diag.sourceforge.net/code/crms-0.1.1.tar.gz
	
	And a bunch of resource monitoring code:
		http://sourceforge.net/project/showfiles.php?group_id=54710

CG people, are you wanting any of this code to be in the main kernel?
If so, why have you not submitted it to anyone yet?  And why did you
write any code before the spec was ready if you said you were not going
to do that?

thanks,

greg k-h
