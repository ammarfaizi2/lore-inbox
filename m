Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131259AbRCHCfx>; Wed, 7 Mar 2001 21:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRCHCfm>; Wed, 7 Mar 2001 21:35:42 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:59410 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S131259AbRCHCf2>; Wed, 7 Mar 2001 21:35:28 -0500
Date: Wed, 7 Mar 2001 20:34:23 -0600
To: Jörn Nettingsmeier 
	<nettings@folkwang-hochschule.de>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: yacc dependency of aic7xxx driver
Message-ID: <20010307203423.A27789@cadcamlab.org>
In-Reply-To: <200103071406.f27E6pO25638@aslan.scsiguy.com> <3AA6576D.81501D0@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.12i
In-Reply-To: <3AA6576D.81501D0@folkwang-hochschule.de>; from nettings@folkwang-hochschule.de on Wed, Mar 07, 2001 at 04:44:45PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jörn Nettingsmeier, quoting Robert Muller]
> Just create a shell script called yacc with the following content
> -------------------
> #!/bin/sh
> bison --yacc $*
> -------------------
> i ran into the same problem with a school proiject here yesterday

Why does nobody learn shell anymore?  (Just curious.)

  #!/bin/sh
  exec bison -y "$@"

Peter
