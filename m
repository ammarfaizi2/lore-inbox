Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbUJYN5C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbUJYN5C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUJYN5C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:57:02 -0400
Received: from sd291.sivit.org ([194.146.225.122]:58813 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S261823AbUJYNzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:55:18 -0400
Date: Mon, 25 Oct 2004 15:56:35 +0200
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Sonypi driver model & PM changes
Message-ID: <20041025135635.GB3161@crusoe.alcove-fr>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org
References: <200410210154.58301.dtor_core@ameritech.net> <20041025125629.GF6027@crusoe.alcove-fr> <200410250822.46023.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410250822.46023.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 08:22:46AM -0500, Dmitry Torokhov wrote:

> If you need a hand - I am a bit familiar with the input system...

See the other mail I just send CC:'ed to Vojtech...

> > Some of your changes (those related to module_param(), wait_event()
> > use etc) were already in my tree, those related to whitespace cleanup,
> > platform instead of sysdev etc are new and I will integrate them.
> >
> 
> The change from sysdev to a platform device is the main reason I did
> the change (and getting rid of old pm_register stuff which is useless
> now) because swsusp2 (and seems that swsusp1 as well) have trouble
> resuming system devices. The rest was just fluff really.

Ok. Suspending never really worked on my laptop so I'll have to assume
you're correct. :)

[ Just tried once again to do a suspend to ram, seems that there were
some enhancements in this area lately. 

  No luck. Machine suspends ok, but upon waking up, the power led goes
  greek ok, the disk led lights up, but the keyboard is dead, the
  network card is dead, the screen doesn't turn on...

  Since this laptop has no serial port I don't see what else I can do,
  except wait another 6 months and try again... :(
]

Stelian.
-- 
Stelian Pop <stelian@popies.net>    
