Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUBTKuk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 05:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbUBTKuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 05:50:40 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:50191 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S261154AbUBTKuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 05:50:39 -0500
Date: Fri, 20 Feb 2004 11:50:13 +0100
From: DervishD <raul@pleyades.net>
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Help with /proc/net/tcp fields
Message-ID: <20040220105013.GA5606@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    I'm trying to decode what the field in the output of
/proc/net/tcp means, with little success. Apart from the fact that
the four last fields have no description (and looking at undocumented
sources is really a pain a very time-consuming), I have the following
doubts:

    - I assume that 'sl' is the socket number, but, what does 'sl'
stand for?
    - What represents the 'st' field?
    - I suppose that 'tr:tm->when' represents if there is any timer
on that socket (well, 'tr' is the number of timers), and when will
expire the nearest one, but I'm not sure.
    - I suppose that 'timeout' is the time to die when the socket is
in FIN_WAIT state, but I'm afraid I'm wrong :(
    - Does the 'retrnsmt' field show the retransmissions happened in
this socket?

    If anyone can explain me these fields (and the unnamed fields at
the end) I will be very grateful, and if someone could direct me to a
site with related information it will help, too.

    Thanks a lot in advance :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
