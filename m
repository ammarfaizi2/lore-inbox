Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284584AbRLETHJ>; Wed, 5 Dec 2001 14:07:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284601AbRLETHA>; Wed, 5 Dec 2001 14:07:00 -0500
Received: from air-1.osdl.org ([65.201.151.5]:6406 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S284579AbRLETEy>;
	Wed, 5 Dec 2001 14:04:54 -0500
Date: Wed, 5 Dec 2001 11:01:02 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Michael Smith <smithmg@agere.com>
cc: "'John Levon'" <movement@marcelothewonderpenguin.com>,
        <linux-kernel@vger.kernel.org>, <kernelnewbies@nl.linux.org>
Subject: RE: Unresolved symbol memset
In-Reply-To: <00a601c17dbe$e6b6ea50$4d129c87@agere.com>
Message-ID: <Pine.LNX.4.33L2.0112051059530.22241-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, Michael Smith wrote:

| I have optimization turned.  Using -02 in the makefile.

That's a capital (upper case) 'O', not a zero (0).

And you should be #include-ing <linux/string.h>, _not_ <string.h>.

~Randy

| I am new to the linux kernel but not kernel development.  If you still
| think this is the wrong list, I will post on the other one.  Sorry if it
| is the wrong list
|
|
| -----Original Message-----
| From: linux-kernel-owner@vger.kernel.org
| [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of John Levon
| Sent: Wednesday, December 05, 2001 1:40 PM
| To: linux-kernel@vger.kernel.org
| Cc: smithmg@agere.com; kernelnewbies@nl.linux.org
| Subject: Re: Unresolved symbol memset
|
| On Wed, Dec 05, 2001 at 01:18:37PM -0500, Michael Smith wrote:
|
| > Hello all,
| >      I am new the Linux world and have a problem which is somewhat
| > confusing.  I am using the system call memset() in kernel code written
| > for Red Hat 7.1(kernel 2.4).  I needed to make this code compatible
| with
| > Red Hat 6.2(kernel 2.2) and seem to be getting a unresolved symbol.
| > This is only happening in one place of the code in one file.  I am
| using
| > memset() in other areas of the code which does not lead to the
| problem.

