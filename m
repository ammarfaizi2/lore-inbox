Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265847AbUBJT6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 14:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265943AbUBJT6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 14:58:55 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40456 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S265847AbUBJT6x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 14:58:53 -0500
Date: Tue, 10 Feb 2004 20:58:49 +0100
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210195849.GA20836@irc.pl>
Mail-Followup-To: Tomasz Torcz <zdzichu@irc.pl>,
	linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <40291A73.7050503@nortelnetworks.com> <20040210192456.GB4814@tinyvaio.nome.ca> <40293508.1040803@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40293508.1040803@nortelnetworks.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 02:46:16PM -0500, Chris Friesen wrote:
> >I think the space savings are a pretty good reason alone. Add to that
> >the fact I think devfs would be a good idea even if it cost MORE
> >memory... You can mount a devfs on your RO root instead of needing to
> >mount a tmpfs on /dev and then run udev on that.
> 
> Don't you have to explicitly mount /dev as type devfs?  How is this 
> different than mounting it as tmpfs?

 There is one magic option in kernel config, which mounts devfs 
automatically at boot.

-- 
Tomasz Torcz            There exists no separation between gods and men:
zdzichu@irc.-nie.spam-.pl   one blends softly casual into the other. 
|> Playing: Anathema - Pressure ...
