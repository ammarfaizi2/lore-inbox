Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266233AbTAOLi4>; Wed, 15 Jan 2003 06:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266243AbTAOLi4>; Wed, 15 Jan 2003 06:38:56 -0500
Received: from [66.70.28.20] ([66.70.28.20]:13074 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266233AbTAOLiz>; Wed, 15 Jan 2003 06:38:55 -0500
Date: Wed, 15 Jan 2003 12:28:31 +0100
From: DervishD <raul@pleyades.net>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115112831.GB66@DervishD>
References: <20030114185934.GA49@DervishD> <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <b020vm$bpm$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b020vm$bpm$1@ncc1701.cistron.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Miquel :))

> >Last time I checked argv[0] was 512 bytes. Many daemons overwrite
> >it with no problem.
> No cigar. This stuff is all set up by the kernel on the stack;

    Thanks a lot for your help :)) FYI, this question is related to
the virtual-console-only init clone that I wrote some time ago (I
used sysvinit for inspiration and good advice), I think I wrote you
about this. Anyway, you are in the acknowledgement list doubly, now
;))) I'm going to release this init in a week or so, after having
using it for more than a year at home without problems.

> If you want to modify argv[0] etc, loop over argv[], count howmuch
> space there is (strlen(argv[0] + 1 + strlen(argv[1] + 1 ... etc)
> and make sure you do NOT write a string longer than that. Also
> make sure that you end the string with a double \0

    How about portability? Not that worries me, since this code will
go to a Linux-only program, just curiosity. Other OSes do the same
stack layout?

    Raúl
