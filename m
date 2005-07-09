Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVGIOYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVGIOYx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 10:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261433AbVGIOYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 10:24:53 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:21666 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261426AbVGIOYw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 10:24:52 -0400
Date: Sat, 9 Jul 2005 16:26:57 +0200
From: DervishD <lkml@dervishd.net>
To: Nico Schottelius <nico-kernel@schottelius.org>,
       linux-kernel@vger.kernel.org
Subject: Re: halt: init exits/panic
Message-ID: <20050709142657.GA166@DervishD>
Mail-Followup-To: Nico Schottelius <nico-kernel@schottelius.org>,
	linux-kernel@vger.kernel.org
References: <20050709151227.GM1322@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050709151227.GM1322@schottelius.org>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Nico :)

 * Nico Schottelius <nico-kernel@schottelius.org> dixit:
> What's the 'correct behaviour' of an init system, if someone wants
> to shutdown the system?

    What I do in my vcinit, the last steps I mean, is:

    reboot(RB_POWER_OFF); /* If halting*/
        or
    reboot(RB_AUTOBOOT); /* If rebooting */

    exit(EXIT_SUCCESS);

    And my vcinit doesn't panic ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
