Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSBLP7v>; Tue, 12 Feb 2002 10:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287287AbSBLP7m>; Tue, 12 Feb 2002 10:59:42 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15121 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S291693AbSBLP7b>; Tue, 12 Feb 2002 10:59:31 -0500
Date: Tue, 12 Feb 2002 15:59:22 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pci_pool reap?
Message-ID: <20020212155922.F31425@flint.arm.linux.org.uk>
In-Reply-To: <20020211.184412.35663889.davem@redhat.com> <1013528224.2240.245.camel@bitch> <20020212154816.E31425@flint.arm.linux.org.uk> <20020212.075051.14974554.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020212.075051.14974554.davem@redhat.com>; from davem@redhat.com on Tue, Feb 12, 2002 at 07:50:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 07:50:51AM -0800, David S. Miller wrote:
> The conclusion we came to is that there is no reason you can't do the
> remapping from interrupts on ARM and propagate the GFP_ATOMIC
> properly as well.  Right?
> 
> Or is this another "I'm not going to make the change until it
> is required of me" situation?  If so I'll just make it so :-)

Well, seeing as I'm currently on 2.5.2 still, waiting for various changes
to stabilise, its still not really high on my priority list.  Things
that are high on it is to move forward RSN and put in place all the
changes for ARM that are needed between 2.5.3-pre1 and 2.5.4.  There's
several bits that need to be looked at, and some of the changes that
have happened in 2.5.2-rmk clash with some of the changes in these
patches, c'est la vie.

Also high is to do something about the growing mountain of patches in
my patch system that need to be processed.

So, I hope you can see that any changes you put into current Linus
kernels won't change the situation for a while because I'm too overloaded
with other stuff and stuck back at 2.5.2 currently.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

