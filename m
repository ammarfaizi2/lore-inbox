Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263217AbRFFN5A>; Wed, 6 Jun 2001 09:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263218AbRFFN4u>; Wed, 6 Jun 2001 09:56:50 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:45831 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S263217AbRFFN4a>;
	Wed, 6 Jun 2001 09:56:30 -0400
Date: Wed, 6 Jun 2001 06:58:39 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Sean Hunter <sean@dev.sportingbet.com>
cc: Xavier Bestel <xavier.bestel@free.fr>, linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <20010606095431.C15199@dev.sportingbet.com>
Message-ID: <Pine.LNX.4.10.10106060651200.7508-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Sean Hunter wrote:

> On Wed, Jun 06, 2001 at 10:19:30AM +0200, Xavier Bestel wrote:
> > On 05 Jun 2001 23:19:08 -0400, Derek Glidden wrote:
> > > On Wed, Jun 06, 2001 at 12:16:30PM +1000, Andrew Morton wrote:
> > > > "Jeffrey W. Baker" wrote:
> > > > > 
> > > > > Because the 2.4 VM is so broken, and
> > > > > because my machines are frequently deeply swapped,
> > > > 
> > > > The swapoff algorithms in 2.2 and 2.4 are basically identical.
> > > > The problem *appears* worse in 2.4 because it uses lots
> > > > more swap.
> > > 
> > > I disagree with the terminology you're using.  It *is* worse in 2.4,
> > > period.  If it only *appears* worse, then if I encounter a situation
> > > where a 2.2 box has utilized as much swap as a 2.4 box, I should see the
> > > same results.  Yet this happens not to be the case. 
> > 
> > Did you try to put twice as much swap as you have RAM ? (e.g. add a 512M
> > swapfile to your box)
> > This is what Linus recommended for 2.4 (swap = 2 * RAM), saying that
> > anything less won't do any good: 2.4 overallocates swap even if it
> > doesn't use it all. So in your case you just have enough swap to map
> > your RAM, and nothing to really swap your apps.
> > 
> 
> For large memory boxes, this is ridiculous.  Should I have 8GB of swap?
> 
> Sean

I have several boxes with 2x ram as swap and performance still sucks
compared to 2.2.17.  

	Gerhard
 


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

