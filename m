Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269890AbRHEBRy>; Sat, 4 Aug 2001 21:17:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269891AbRHEBRo>; Sat, 4 Aug 2001 21:17:44 -0400
Received: from NS.iNES.RO ([193.230.220.1]:8926 "EHLO smtp.ines.ro")
	by vger.kernel.org with ESMTP id <S269890AbRHEBR0>;
	Sat, 4 Aug 2001 21:17:26 -0400
Message-ID: <3B6C9CC0.819CA53C@interplus.ro>
Date: Sun, 05 Aug 2001 04:09:20 +0300
From: Mircea Ciocan <mirceac@interplus.ro>
Organization: Home Office
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-ac2 i686)
X-Accept-Language: ro, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ip_conntrack bigger, better and yellow ;) !!!
In-Reply-To: <20010804113841.A2196@zero> <3B6C7F9B.30303@yahoo.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Ok, the pressure for a netflow like stuff in kernel is big, examining
the the netflow structure at:

 http://sgi.rdscv.ro/~ionuts/netflowv5.h

it seem that ip_conntrak has allmost everything that is needed to
emulate Cisco netflow EXCEPT ( a big except :) the information about
data bytes/packets that flow via that connexion and the question is how
could be added with minimum damages, for example at the end of the
existing ip_conntrack structure, so a nice little userspace daemon could
parse the /proc/net/ip_conntrack and generate the damned netflow packets
that everybody seem to want now :( !!!
	Me and a couple of friends are ready to cut our teeth in kernel
programing and have available some machines to crash test and debug the
damned thing and while not aiming for inclusion in stable series maybe
it will mature enough for inclusion in 2.6 series or it will remain a
forever unofficial pach :).
	While we think that we know enough C and we can dig throu kernel
sources we need some mentoring, kickstart and stuff from you network
gurus to tell us where is the best this code to be inserted ( is your
stack after all ;) and some best design ideeas.
	We promise to do the grunt work and keep the "bothering level" at a
minimum :).
	So Alexey, DaveM, Alan and the other network gurus, please help us to
put our name somewhere in the CREDITS file ;).

		Thank you,

		Mircea C.
