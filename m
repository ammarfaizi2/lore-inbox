Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270134AbRH1B5e>; Mon, 27 Aug 2001 21:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270155AbRH1B5Y>; Mon, 27 Aug 2001 21:57:24 -0400
Received: from mailsrv.rollanet.org ([192.55.114.7]:19228 "HELO
	mx.rollanet.org") by vger.kernel.org with SMTP id <S270134AbRH1B5E>;
	Mon, 27 Aug 2001 21:57:04 -0400
Message-ID: <3B8AFA81.6B10190C@umr.edu>
Date: Mon, 27 Aug 2001 20:57:21 -0500
From: Nathan Neulinger <nneul@umr.edu>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Blocking bind to outbound interface?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any way to block use of an interface for outbound connections?

I have a host who's primary outbound interface is on a private network
(using a private address block for our backbone). Unfortunately, this
means that most applications (those not providing an option to select
bind address) will bind to this private-net address when establishing
outbound connections or sending udp packets.

The host has another address which is a publically accessible ip, but
it's not the default route interface.

Is there any way to hide this interface on the host for ALL outbound
connections without modifying all applications/app invocations? Or some
way of overriding the mechanism for selection of default interface.

-- Nathan

------------------------------------------------------------
Nathan Neulinger                       EMail:  nneul@umr.edu
University of Missouri - Rolla         Phone: (573) 341-4841
CIS - Systems Programming                Fax: (573) 341-4216
