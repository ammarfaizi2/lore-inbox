Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290289AbSCJEif>; Sat, 9 Mar 2002 23:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292718AbSCJEi0>; Sat, 9 Mar 2002 23:38:26 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9982
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S290289AbSCJEiL>; Sat, 9 Mar 2002 23:38:11 -0500
Date: Sat, 9 Mar 2002 20:38:54 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Robert Love <rml@tech9.net>
Cc: charles-heselton@cox.net, Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Dan Mann <mainlylinux@attbi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Kernel 2.5.6 Interactive performance
Message-ID: <20020310043854.GA311@matchmail.com>
Mail-Followup-To: Robert Love <rml@tech9.net>, charles-heselton@cox.net,
	Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
	Dan Mann <mainlylinux@attbi.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	"J.A. Magallon" <jamagallon@able.es>
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPKEPDCFAA.charles-heselton@cox.net> <1015734229.858.4.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1015734229.858.4.camel@phantasy>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 09, 2002 at 11:23:48PM -0500, Robert Love wrote:
> On Sat, 2002-03-09 at 20:15, Charles Heselton wrote:
> 
> > That would be great.  I'm currently running 2.4.18.  I'm always up for
> > things that would help improve performance, even if they are "experimental".
> 
> A good base is Alan's tree, available at:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/alan/linux-2.4/2.4.19/patch-2.4.19-pre2-ac4.gz
> 
> which is to be applied on top of 2.4.19-pre2.  It contains the O(1)
> scheduler and rmap VM.  If you are interested in preemption, the
> preempt-kernel patch is available at:
> 
> 	http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/
> 
> The 2.5 tree also has most of these toys, and is a better place for this
> development IMO.  Personally, I'd stay away from these all-in-one silly
> patches that are floating around these days.  Your safest bet is just
> stock 2.4.18 or whatever is latest, although the above addons are all at
> varying levels of "stable" and "safe".
> 

Then what do you call -aa and -ac? ;)

These "all-in-one" patches do make it harder to debug specific patches, but
it does create a wider audience for many patches that wouldn't be used
otherwise.
