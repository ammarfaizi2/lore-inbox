Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267754AbRG0LTX>; Fri, 27 Jul 2001 07:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268705AbRG0LTM>; Fri, 27 Jul 2001 07:19:12 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:53766 "HELO dvmwest.gt.owl.de")
	by vger.kernel.org with SMTP id <S267754AbRG0LSw>;
	Fri, 27 Jul 2001 07:18:52 -0400
Date: Fri, 27 Jul 2001 13:18:58 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linx Kernel Source tree and metrics
Message-ID: <20010727131858.H11840@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010727095757Z268814-721+5010@vger.kernel.org> <15201.17117.641766.521810@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15201.17117.641766.521810@notabene.cse.unsw.edu.au>; from neilb@cse.unsw.edu.au on Fri, Jul 27, 2001 at 08:30:53PM +1000
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Fri, Jul 27, 2001 at 08:30:53PM +1000, Neil Brown wrote:
> On Friday July 27, puckwork@madz.net wrote:
> > >> > > The URL is:
> > >> >
> > >> > > http://24.5.14.144:3000/linux-kernel
> > 
> > http://keroon.dmz.dreampark.com:3000/linux-kernel/
> > 
> > Can't be found (DNS-Error)

The problem is that the HTTP server on given IP address responds with
its *name* in the URL. This means that $WEBBROWSER uses the name in
its next connection attempt (-> load any given frame).

So one has to add "24.5.14.144 keroon.dmz.dreampark.com" to /etc/hosts
to use it...

MfG, JBG

