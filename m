Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263459AbTFDPn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263461AbTFDPn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 11:43:57 -0400
Received: from dan.arc.nasa.gov ([143.232.69.77]:27521 "EHLO rudi.arc.nasa.gov")
	by vger.kernel.org with ESMTP id S263459AbTFDPn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 11:43:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Dan Christian <Daniel.A.Christian@NASA.gov>
Reply-To: Daniel.A.Christian@NASA.gov
Organization: NASA Ames Research Center
To: Clemens Schwaighofer <cs@tequila.co.jp>,
       "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols
Date: Wed, 4 Jun 2003 08:57:15 -0700
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200306031728.41982.Daniel.A.Christian@NASA.gov> <20030604083150.GA2770@werewolf.able.es> <3EDDBD16.9050301@tequila.co.jp>
In-Reply-To: <3EDDBD16.9050301@tequila.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306040857.15782.Daniel.A.Christian@NASA.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 June 2003 02:34, Clemens Schwaighofer wrote:
> J.A. Magallon wrote:
> > You're missing a make install, I think ( at least this is what I
> > do, perhaps something is redundant:
>
> make install only works if you have something like
> "install_kernel.sh" script available in your system. not all systems
> have that. so it might just fail. and there is no problem by copying
> the System.map and bzImage by hand to the /boot directory

Right.  I just copy by hand.

The kernel will boot just fine, but it can't load most of it's modules.

-Dan
