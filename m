Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266178AbUA1Vno (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 16:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266204AbUA1Vno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 16:43:44 -0500
Received: from adsl-19-228-178.jax.bellsouth.net ([68.19.228.178]:41511 "EHLO
	theorem093.dyndns.org") by vger.kernel.org with ESMTP
	id S266178AbUA1Vnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 16:43:43 -0500
Date: Wed, 28 Jan 2004 16:45:12 -0500
From: Zack Winkles <winkie@linuxfromscratch.org>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Official NVIDIA drivers for 2.6
Message-ID: <20040128214512.GA7647@theorem093.dyndns.org>
Mail-Followup-To: Zack Winkles <winkie@linuxfromscratch.org>,
	Voicu Liviu <pacman@mscc.huji.ac.il>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200401280945.42190.kernel@kolivas.org> <4017BFF8.7060706@mscc.huji.ac.il> <401807DC.9010701@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401807DC.9010701@mscc.huji.ac.il>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 09:05:00PM +0200, Voicu Liviu wrote:
> I have a Prophet 3D Radeon 9600 Pro 128 Ram, any chance to have it
> working with 2.6x ?

Yes.  I've been using fglrx in 2.6 for the longest time.  The key is to
to put '#if 0' & '#endif' around the code of the function, and put in
'return 0' at the bottom.  Compile, install, and enjoy.

