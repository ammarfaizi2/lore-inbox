Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132932AbRDJFis>; Tue, 10 Apr 2001 01:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132933AbRDJFii>; Tue, 10 Apr 2001 01:38:38 -0400
Received: from ferret.phonewave.net ([208.138.51.183]:54544 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S132932AbRDJFi1>; Tue, 10 Apr 2001 01:38:27 -0400
Date: Mon, 9 Apr 2001 22:37:16 -0700
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Sources of entropy - /dev/random problem for network servers
Message-ID: <20010409223716.A7395@ferret.phonewave.net>
In-Reply-To: <27525795B28BD311B28D00500481B7601F1193@ftrs1.intranet.ftr.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <27525795B28BD311B28D00500481B7601F1193@ftrs1.intranet.ftr.nl>; from f.v.heusden@ftr.nl on Mon, Apr 09, 2001 at 01:04:47PM +0200
From: idalton@ferret.phonewave.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2001 at 01:04:47PM +0200, Heusden, Folkert van wrote:
> >> However, only 3 drivers in drivers/net actually set
> >> SA_SAMPLE_RANDOM when calling request_irq(). I believe
> >> all of them should.
> > No, because an attacker can potentially control input and make it
> > non-random.
> AB> 2. Given that otherwise in at least my application (and machine
> AB> without keyboard and mouse can't be too uncommon) there is *no*
> AB> entropy otherwise, which is rather easier for a hacker. At least
> 
> Put a soundcard in your system and install audio-entropyd.
> Works pretty nice.

Do you know where to find it? Freshmeat has a listing, but it's pointing
to mindrot.org and is 404 not found.

-- Ferret
