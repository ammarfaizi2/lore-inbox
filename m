Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132483AbRDJXrU>; Tue, 10 Apr 2001 19:47:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132484AbRDJXrL>; Tue, 10 Apr 2001 19:47:11 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:58127 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S132483AbRDJXq4>; Tue, 10 Apr 2001 19:46:56 -0400
Date: Wed, 11 Apr 2001 01:46:52 +0200
From: Kurt Roeckx <Q@ping.be>
To: Miquel van Smoorenburg <miquels@cistron-office.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Let init know user wants to shutdown
Message-ID: <20010411014652.A9756@ping.be>
In-Reply-To: <20010405000215.A599@bug.ucw.cz> <9b04fo$9od$3@ncc1701.cistron.net> <20010411013830.A9704@ping.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010411013830.A9704@ping.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2001 at 01:38:30AM +0200, Kurt Roeckx wrote:
> On Tue, Apr 10, 2001 at 11:20:24PM +0000, Miquel van Smoorenburg wrote:
> > 
> > the shutdown scripts
> > include "kill -15 -1; sleep 2; kill -9 -1". The "-1" means
> > "all processes except me". That means init will get hit with
> > SIGTERM occasionally during shutdown, and that might cause
> > weird things to happen.
> 
> -1 mean everything but init.

Oh, maybe you mean killall5 -TERM?

Which would send a SIGTERM to all processes but the one in his
own session.

(Hey look, you wrote that manpage.)


Kurt

