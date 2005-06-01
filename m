Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261443AbVFAPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261443AbVFAPy7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 11:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVFAPyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 11:54:04 -0400
Received: from atpro.com ([12.161.0.3]:37389 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S261437AbVFAPwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 11:52:40 -0400
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Wed, 1 Jun 2005 11:48:25 -0400
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <20050601154825.GB14299@voodoo>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
	linux-kernel@vger.kernel.org, dtor_core@ameritech.net, 7eggert@gmx.de
References: <26A66BC731DAB741837AF6B2E29C10171E60DE@xmb-hkg-413.apac.cisco.com> <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <20050531172204.GD17338@voodoo> <429DD432.nail7BF810RPU@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <429DD432.nail7BF810RPU@burner>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/05 05:28:50PM +0200, Joerg Schilling wrote:
> > The rules and scripts that udev uses to name things can do anything since
> > it runs in userland, so udev could easily edit /etc/default/cdrecord if
> > someone took the time to write the script.
> 
> If it has the knowledge and if it is able to run parameterized sed from 
> internal rules, it should be possible to configure udev to 
> modify /etc/default/cdrecord, but as I don't have such a system, it would
> be nice if this was done by someone else.

I doubt anyone would want to do that, as soon as a script for cdrecord
gets submitted people will start submitting scripts for other tools and I
really doubt the udev maintainer has the resources or desire to maintain
dozens of scripts for tools that he doesn't use. If such scripts were to be
written they would most likely have to be maintained either by the upstream 
author or by a package maintainer for a particular distribution that wants 
to hack around the lack of Linux integration in a particular tool.

> 
> Jörg
> 

Jim.

