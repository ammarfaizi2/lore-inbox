Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030589AbVKXECv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030589AbVKXECv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 23:02:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030591AbVKXECv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 23:02:51 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:63894
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1030589AbVKXECv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 23:02:51 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Wed, 23 Nov 2005 22:02:37 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511230258.33901.rob@landley.net> <20051123132106.GC23159@elf.ucw.cz>
In-Reply-To: <20051123132106.GC23159@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511232202.38294.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 November 2005 07:21, Pavel Machek wrote:
> Ok, this one applied okay for me. It still does not seem to work:
>
> pavel@amd:/data/l/linux$ scripts/miniconfig.sh config.ok
> Calculating mini.config...
> pavel@amd:/data/l/linux$ cat mini.config
> CONFIG_PM=y
> pavel@amd:/data/l/linux$
>
> ...and yes, my config is definitely more complex than that, I
> handselected only relevant PCI cards, for example.

This is a wild hunch, but try changing the #!/bin/sh at the top of 
miniconfig.sh to #!/bin/bash and see if that makes a difference?  (I vaguely 
remember an ancient email where you're using a funky shell?)

Rob
