Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132484AbRDJXyA>; Tue, 10 Apr 2001 19:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132485AbRDJXxw>; Tue, 10 Apr 2001 19:53:52 -0400
Received: from 10fwd.cistron-office.nl ([195.64.65.197]:58641 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id <S132484AbRDJXxk>; Tue, 10 Apr 2001 19:53:40 -0400
Date: Wed, 11 Apr 2001 01:53:38 +0200
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: Kurt Roeckx <Q@ping.be>
Cc: Miquel van Smoorenburg <miquels@cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010411015338.A21044@cistron.nl>
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04fo$9od$3@ncc1701.cistron.net> <20010411013830.A9704@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010411013830.A9704@ping.be>; from Q@ping.be on Wed, Apr 11, 2001 at 01:38:30AM +0200
X-NCC-RegID: nl.cistron
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Kurt Roeckx:
> On Tue, Apr 10, 2001 at 11:20:24PM +0000, Miquel van Smoorenburg wrote:
> > The "-1" means
> > "all processes except me". That means init will get hit with
> > SIGTERM occasionally during shutdown, and that might cause
> > weird things to happen.
> 
> -1 mean everything but init.
> 
> From the manpage:

Oh. OK, so this is yet another special case for init - forget to
check those. Sorry about that (hey it's 01:53 here, I should be
in bed).  Yet I still think it'd be a better idea to use RT signals,
see my other message in this thread.

Mike.
