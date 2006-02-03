Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030192AbWBCSiu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030192AbWBCSiu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030196AbWBCSit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:38:49 -0500
Received: from hummeroutlaws.com ([12.161.0.3]:26385 "EHLO atpro.com")
	by vger.kernel.org with ESMTP id S1030192AbWBCSis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:38:48 -0500
From: "Jim Crilly" <jim@why.dont.jablowme.net>
Date: Fri, 3 Feb 2006 13:37:19 -0500
To: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203183719.GB11241@voodoo>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo> <20060203180421.GA57965@dspnet.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203180421.GA57965@dspnet.fr.eu.org>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03/06 07:04:21PM +0100, Olivier Galibert wrote:
> On Fri, Feb 03, 2006 at 10:53:50AM -0500, Jim Crilly wrote:
> > A bug in HAL is not a bug in Linux. If the HAL people need to make some
> > changes to their daemon to make it play nice with cdrecord and the like
> > that's fine, but telling people here makes no sense.
> 
> Actually, since at that point in time HAL is the only way to do device
> discovery with the linux kernel, problems in HAL are problems in
> linux.  There is *no* other way than HAL to do the mapping between a
> point in the sysfs tree and a device node in /dev[1].
> 
>   OG.
> 
> [1] Unless you consider stating every node in /dev acceptable just to
> find the correct major/minor.

It's not about device discovery, hald is polling removable devices every 2s
to see if new media was inserted and when it polls a CD drive that's
currently burning a disc it causes problems. It's documented in Debian bug
#262678.

Jim.
