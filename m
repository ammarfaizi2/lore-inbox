Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276327AbRI1VxW>; Fri, 28 Sep 2001 17:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276328AbRI1VxM>; Fri, 28 Sep 2001 17:53:12 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:37618
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276327AbRI1VxE>; Fri, 28 Sep 2001 17:53:04 -0400
Date: Fri, 28 Sep 2001 14:53:24 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tools better than vmstat [was: 2.4.9-ac16 good perfomer?]
Message-ID: <20010928145324.A14801@mikef-linux.matchmail.com>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109281826.f8SIQLP06585@deathstar.prodigy.com> <Pine.LNX.4.33L.0109281535220.26495-100000@duckman.distro.conectiva> <20010928123455.B8222@mikef-linux.matchmail.com> <20010928210453.B15457@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010928210453.B15457@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2001 at 09:04:53PM +0100, Russell King wrote:
> On Fri, Sep 28, 2001 at 12:34:55PM -0700, Mike Fedyk wrote:
> > I read not too long ago about someone mentioning a patch that lists the ages
> > of pages via a proc interface...
> 
> I have a patch that dumps out all sorts of information on sysrq-g and
> sysrq-h, including page ages as you describe above.  Rik has this patch,
> but you really do need a serial console and not a lot of RAM to use it
> (or a lot of patience).
> 

Hmm.

Ok, can someone tell me how many different ages there can be in the VM?  

I'm thinkin of a tool (vm-page-stat?) that will list the percentage of pages
at a specific (or if there are more than ~10 page ages possible, it could
use ranges...) age much like vmstat does now.

Is there any possibility of using Russell's patch for this user space tool?
Maybe Russel's patch could have a proc interface that vm-page-stat would
read to get a snapshot?

It would certainly be more helpful than vmstat alone...

Comments?
