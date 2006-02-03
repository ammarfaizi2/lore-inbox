Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbWBCSEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbWBCSEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 13:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbWBCSEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 13:04:33 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:34063 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1750981AbWBCSEc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 13:04:32 -0500
Date: Fri, 3 Feb 2006 19:04:21 +0100
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060203180421.GA57965@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <20060202062840.GI5501@mail> <43E1EA35.nail4R02QCGIW@burner> <20060202161853.GB8833@voodoo> <787b0d920602020917u1e7267c5lbea5f02182e0c952@mail.gmail.com> <Pine.LNX.4.61.0602022138260.30391@yvahk01.tjqt.qr> <20060202210949.GD10352@voodoo> <43E27792.nail54V1B1B3Z@burner> <787b0d920602021827m4890fbf4j24d110dc656d2d3a@mail.gmail.com> <43E374CF.nail5CAMKAKEV@burner> <20060203155349.GA9301@voodoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060203155349.GA9301@voodoo>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 10:53:50AM -0500, Jim Crilly wrote:
> A bug in HAL is not a bug in Linux. If the HAL people need to make some
> changes to their daemon to make it play nice with cdrecord and the like
> that's fine, but telling people here makes no sense.

Actually, since at that point in time HAL is the only way to do device
discovery with the linux kernel, problems in HAL are problems in
linux.  There is *no* other way than HAL to do the mapping between a
point in the sysfs tree and a device node in /dev[1].

  OG.

[1] Unless you consider stating every node in /dev acceptable just to
find the correct major/minor.
