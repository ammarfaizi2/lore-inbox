Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136445AbREDQ05>; Fri, 4 May 2001 12:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136450AbREDQ0r>; Fri, 4 May 2001 12:26:47 -0400
Received: from pc-25-211.mountaincable.net ([24.215.25.211]:41437 "HELO
	adrock.vbfx.com") by vger.kernel.org with SMTP id <S136445AbREDQ0i>;
	Fri, 4 May 2001 12:26:38 -0400
Message-ID: <3AF2D842.3DD33B6A@vbfx.com>
Date: Fri, 04 May 2001 12:26:42 -0400
From: Adam <adam@vbfx.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: "Michael K. Johnson" <johnsonm@redhat.com>
Subject: Re: dhcp problem with realtek 8139 clone with rh 7.1
In-Reply-To: <200105041520.f44FKUM07323@bastable.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael K. Johnson" wrote:
> 
> In linux-kernel, you wrote:
> >I have som problem with my realtek 8139 clone. It won't work with dhcp
> >against my isp. I've just installed redhat 7.1 on a i386 with to (exactly
> >the same) network cards, one that should be connected to my isp, and one
> >to
> >the local network. My local network works fine, but when I try to start
> >eth0
> >(which is the card connecting to my isp) I get
> >
> >Determining IP configuration... Operation failed.
> >   failed.
> >
> >If I manually try to run 'pump -i eth0' I also get Operation failed.
> 
> This sounds more like pump failing to negotiate dhcp properly than
> like a failure in the driver.  Let's check that possibility first
> before assuming a driver bug.
> 
> Install dhcpcd, chmod a-x /sbin/pump, and see if it works better
> (if pump is not there or not executable, the scripts fall back to
> dhcpcd).  If so, please file a bug report against pump in buzilla
> http://bugzilla.redhat.com/bugzilla/
> 
> michaelkjohnson
> 
>  "He that composes himself is wiser than he that composes a book."
>  Linux Application Development                     -- Ben Franklin
>  http://people.redhat.com/johnsonm/lad/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I've had the same problem with the 8139too drivers and DHCP.  The reason
I figure it must be the drivers is because in the 2.4.3 kernel, I'm able
to use the 8139too drivers with DHCP without any problems.  In 2.4.4 it
locks my system.

-- 
Adam
adam@vbfx.com
Linux user #190288
