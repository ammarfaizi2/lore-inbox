Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261477AbSJDEoN>; Fri, 4 Oct 2002 00:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261478AbSJDEoN>; Fri, 4 Oct 2002 00:44:13 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:2830 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261477AbSJDEoM>;
	Fri, 4 Oct 2002 00:44:12 -0400
Date: Thu, 3 Oct 2002 21:46:53 -0700
From: Greg KH <greg@kroah.com>
To: Muli Ben-Yehuda <mulix@actcom.co.il>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
Message-ID: <20021004044652.GA3556@kroah.com>
References: <20021003153943.E22418@openss7.org> <20021003221525.GA2221@kroah.com> <20021003222716.GB14919@suse.de> <1033684027.1247.43.camel@phantasy> <20021003225842.GA79989@compsoc.man.ac.uk> <20021004040503.GH15215@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021004040503.GH15215@actcom.co.il>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 04, 2002 at 07:05:03AM +0300, Muli Ben-Yehuda wrote:
> 
> http://marc.theaimsgroup.com/?l=kernelnewbies&m=102267164910800&w=2, 

You didn't read my post to that same thread did you:
	http://marc.theaimsgroup.com/?l=kernelnewbies&m=102130770415962

And for the most part, the people on kernelnewbies have given up on
trying to explain to new people why this does not work.  I know I sure
have :)

> http://marc.theaimsgroup.com/?l=linux-kernel&m=101821127019203&w=2
> 
> [2] Can the LSM hooks be used for notification and modification on
> every system call's entry and exit?  

No.  See the LSM mailing list archives for why we did not decide to do
this.  (hint, you don't really achieve what you want to by doing this.)

If you _really_ want to hook things like this, look at LTT or dprobes.
They should work just fine for you.

thanks,

greg k-h
