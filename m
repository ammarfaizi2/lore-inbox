Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUG0J5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUG0J5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 05:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261951AbUG0J5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 05:57:43 -0400
Received: from madrid10.amenworld.com ([62.193.203.32]:33546 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261252AbUG0J5l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 05:57:41 -0400
Date: Tue, 27 Jul 2004 11:57:51 +0200
From: DervishD <raul@pleyades.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: The dreadful CLOSE_WAIT
Message-ID: <20040727095751.GA10048@DervishD>
Mail-Followup-To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
	linux-kernel@vger.kernel.org
References: <20040727083947.GB31766@DervishD> <yw1xllh5ol3i.fsf@kth.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xllh5ol3i.fsf@kth.se>
User-Agent: Mutt/1.4.2.1i
Organization: Pleyades
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Måns :)

 * Måns Rullgård <mru@kth.se> dixit:
> >     Seems under Linux that, when a connection is in the CLOSE_WAIT
> > state, the only wait to go to LAST_ACK is the application doing the
> > 'shutdown()' or 'close()'. Doesn't seem to be a timeout for that.
> Is that why some programs seem to hang forever when my NAT gateway
> decides to drop a connection?

    I don't know. Look at the output of your netstat command. If you
have connections in the CLOSE_WAIT state related to the NAT gateway,
it may be the cause :? But anyway the effect is just the opposite. Is
not CLOSE_WAIT state that hangs a program, but a hung program (or at
least one not doing its duty) which puts a connection in CLOSE_WAIT
state.

    Hope this helps.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
