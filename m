Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSFTOGE>; Thu, 20 Jun 2002 10:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSFTOGD>; Thu, 20 Jun 2002 10:06:03 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:11832 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312560AbSFTOGC>; Thu, 20 Jun 2002 10:06:02 -0400
Date: Thu, 20 Jun 2002 16:07:15 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620140715.GK10718@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random> <20020620130511.GA8426@werewolf.able.es> <20020620133249.GG10718@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020620133249.GG10718@dualathlon.random>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

it seems in your last jam2 you reintroduced a bug fixed in mainline with
the smptimers patch, that can crash the kernel in the smptimers, see the
run_timer_list_running global variable.

Andrea
