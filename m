Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263703AbRFFI6W>; Wed, 6 Jun 2001 04:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263804AbRFFI6M>; Wed, 6 Jun 2001 04:58:12 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:50948 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S263703AbRFFI6G>; Wed, 6 Jun 2001 04:58:06 -0400
Date: Wed, 6 Jun 2001 09:54:31 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010606095431.C15199@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com> <Pine.LNX.4.33.0106051634540.8311-100000@heat.gghcwest.com> <3B1D927E.1B2EBE76@uow.edu.au> <20010605231908.A10520@illusionary.com> <991815578.30689.1.camel@nomade>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <991815578.30689.1.camel@nomade>; from xavier.bestel@free.fr on Wed, Jun 06, 2001 at 10:19:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2001 at 10:19:30AM +0200, Xavier Bestel wrote:
> On 05 Jun 2001 23:19:08 -0400, Derek Glidden wrote:
> > On Wed, Jun 06, 2001 at 12:16:30PM +1000, Andrew Morton wrote:
> > > "Jeffrey W. Baker" wrote:
> > > > 
> > > > Because the 2.4 VM is so broken, and
> > > > because my machines are frequently deeply swapped,
> > > 
> > > The swapoff algorithms in 2.2 and 2.4 are basically identical.
> > > The problem *appears* worse in 2.4 because it uses lots
> > > more swap.
> > 
> > I disagree with the terminology you're using.  It *is* worse in 2.4,
> > period.  If it only *appears* worse, then if I encounter a situation
> > where a 2.2 box has utilized as much swap as a 2.4 box, I should see the
> > same results.  Yet this happens not to be the case. 
> 
> Did you try to put twice as much swap as you have RAM ? (e.g. add a 512M
> swapfile to your box)
> This is what Linus recommended for 2.4 (swap = 2 * RAM), saying that
> anything less won't do any good: 2.4 overallocates swap even if it
> doesn't use it all. So in your case you just have enough swap to map
> your RAM, and nothing to really swap your apps.
> 

For large memory boxes, this is ridiculous.  Should I have 8GB of swap?

Sean
