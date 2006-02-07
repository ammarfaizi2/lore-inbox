Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbWBGXtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbWBGXtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030290AbWBGXtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:49:13 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:47543 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1030293AbWBGXtL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:49:11 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <nigel@suspend2.net>
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Date: Wed, 8 Feb 2006 00:50:21 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Bojan Smojver <bojan@rexursive.com>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060207230510.GF2753@elf.ucw.cz> <200602080917.24305.nigel@suspend2.net>
In-Reply-To: <200602080917.24305.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080050.22158.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wednesday 08 February 2006 00:17, Nigel Cunningham wrote:
}-- snip --{
> 
> It occured to me as soon as I sent the last email (don't you hate that!)
> that I'd forgotten the original impetus: backwards compatibility. If all
> of the methods of suspending can be started with
> 
> "echo disk > /sys/power/state"
> 
> , your backwards compatability issue that you expressed concern about 
> earlier in this discussion is addressed. So, I'm not sure that dropping the
> idea is the right thing to do.

I'm not sure if the problem is real.  If it turns out to be, it'll be solvable
in a couple of sane ways, so I don't think we need to worry about it
in advance.

I'd like the userland suspend to be an option and not a drop-in replacement
of swsusp or suspend2, so IMO it can be started in a different way.

Greetings,
Rafael
