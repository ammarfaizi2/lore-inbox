Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290794AbSAaBYJ>; Wed, 30 Jan 2002 20:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290798AbSAaBXx>; Wed, 30 Jan 2002 20:23:53 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:21775 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S290805AbSAaBV1>; Wed, 30 Jan 2002 20:21:27 -0500
Date: Wed, 30 Jan 2002 19:21:19 -0600
To: A Guy Called Tyketto <tyketto@wizard.com>
Cc: kbuild-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: make xconfig whinges about Configure.help
Message-ID: <20020131012119.GR645@cadcamlab.org>
In-Reply-To: <20020131001609.GA31911@wizard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131001609.GA31911@wizard.com>
User-Agent: Mutt/1.3.25i
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[A Guy Called Tyketto]
>         Just an FYI.. when one runs 'make xconfig', and goes to request help 
> on a certain option given, a message comes up:

Known issue.  Configure.help has been split up, menuconfig and xconfig
don't know this yet.  If you want to fix it, feel free.  It's probably
not all that hard - just remember what directory you read Config.in
from and look for Configure.help there.

The current config tools are (it is believed) approaching the end of
their lifecycle, so most of the usual suspects aren't terribly eager to
hack on them in 2.5.  That's probably why this isn't fixed yet.

Peter
