Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263966AbSKDAMD>; Sun, 3 Nov 2002 19:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263986AbSKDAMD>; Sun, 3 Nov 2002 19:12:03 -0500
Received: from almesberger.net ([63.105.73.239]:1289 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S263966AbSKDAMC>; Sun, 3 Nov 2002 19:12:02 -0500
Date: Sun, 3 Nov 2002 21:18:15 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: Nicholas Wourms <nwourms@netscape.net>,
       Flavio Stanchina <flavio.stanchina@tin.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
Message-ID: <20021103211815.L2599@almesberger.net>
References: <200211031809.45079.josh@stack.nl> <aq41b9$dt9$1@main.gmane.org> <3DB5E7CA00439C7E@smtp2.cp.tin.it> <3DC593A8.2030204@netscape.net> <20021103220023.GA16889@citd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021103220023.GA16889@citd.de>; from ms@citd.de on Sun, Nov 03, 2002 at 11:00:23PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Schniedermeyer wrote:
> The config gets a version-Tag.

This would only be helpful if you also had a description of what the
user is expected to change. (And once you have this, you might as
well automate the process a little more, as I've just described in
another posting.)

Just telling the user that there might be problems isn't very helpful,
in particular since most such version conflicts would be false alarms,
e.g. name changes of some obscure controller I don't have anyway. I
think most people are aware of the fact that "make oldconfig" may
produce nonsense, but it's still annoying if it does.

Another easy extension to consider: after "make oldconfig", print
the options that were found in .config, but which don't exist anymore.
I've actually proposed this already two years ago, see also
http://marc.theaimsgroup.com/?l=linux-kernel&m=97298980521513&w=2

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
