Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263232AbRFYJrC>; Mon, 25 Jun 2001 05:47:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263366AbRFYJqx>; Mon, 25 Jun 2001 05:46:53 -0400
Received: from relay.dera.gov.uk ([192.5.29.49]:21523 "HELO relay.dera.gov.uk")
	by vger.kernel.org with SMTP id <S263232AbRFYJqi>;
	Mon, 25 Jun 2001 05:46:38 -0400
Subject: Re: [UPDATE] Directory index for ext2
From: Tony Gale <gale@syntax.dera.gov.uk>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Heusden@vger.kernel.org, Folkert van <f.v.heusden@ftr.nl>,
        linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
        Alexander Viro <viro@math.psu.edu>,
        Andreas Dilger <adilger@turbolinux.com>
In-Reply-To: <01062018584308.00439@starship>
In-Reply-To: <0105311813431J.06233@starship>
	<993049198.3089.2.camel@syntax.dera.gov.uk>  <01062018584308.00439@starship>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 25 Jun 2001 10:46:35 +0100
Message-Id: <993462395.9593.0.camel@syntax.dera.gov.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After some testing, removing the grsecurity patch seems to have solved
the disappearing-free-space problem. Now just need to find out why.


On 20 Jun 2001 18:58:43 +0200, Daniel Phillips wrote:
> On Wednesday 20 June 2001 16:59, Tony Gale wrote:
> > The main problem I have with this is that e2fsck doesn't know how to
> > deal with it - at least I haven't found a version that will. This makes
> > it rather difficult to use, especially for your root fs.
> 
> Good, the file format isn't finalized, this is only recommended for use on a 
> test partition.

It was a test partition, just happended to be a root one. AFAIAA, isn't
the fact that the file format may change irrelevant. You want people to
test this stuff or not? If it's not tested on a root fs then how do you
know there won't be any problems.

Sorry, but when someone reports a problem, and then you say, well don't
test it like that then, it is really not acceptable.

-tony


