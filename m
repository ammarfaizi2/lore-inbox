Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277724AbRJLPBl>; Fri, 12 Oct 2001 11:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277722AbRJLPBc>; Fri, 12 Oct 2001 11:01:32 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:34482
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S277724AbRJLPB1>; Fri, 12 Oct 2001 11:01:27 -0400
Date: Fri, 12 Oct 2001 08:01:29 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Keith Owens <kaos@ocs.com.au>, Benjamin LaHaise <bcrl@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Modutils 2.5 change, start running this command now
Message-ID: <20011012080129.B9992@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <7202.1002886635@ocs3.intra.ocs.com.au> <20283.1002888881@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20283.1002888881@redhat.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 01:14:41PM +0100, David Woodhouse wrote:
> 
> kaos@ocs.com.au said:
> >  I was going to do it that way.  The problem is that it gives no
> > indication if the module has been checked or not.  Adding
> > EXPORT_NO_SYMBOLS says that somebody has reviewed the module and
> > decided that exporting no symbols is the correct behaviour.  It is the
> > difference between no maintainer and a maintained module. 
> 
> If all you want to know is whether modules are maintained or not, look to 
> see how many have had MODULE_LICENSE(sic) tags added. 

Not really.  There's been people auditing the drivers, which is probably
what would happen here.  Either way even.  Forcing a break will make it
much more obvious is all.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
