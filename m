Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbVKFB0M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbVKFB0M (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 20:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVKFB0M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 20:26:12 -0500
Received: from smtpout1.uol.com.br ([200.221.4.192]:60670 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S932269AbVKFB0L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 20:26:11 -0500
Date: Sat, 5 Nov 2005 23:25:59 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hfsplus: don't modify journaled volume
Message-ID: <20051106012559.GA3830@ime.usp.br>
Mail-Followup-To: Anton Altaparmakov <aia21@cam.ac.uk>,
	Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0511031617090.12843@scrub.home> <20051104210213.1232a007.akpm@osdl.org> <Pine.LNX.4.64.0511051009090.13104@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.64.0511051333550.13104@hermes-1.csi.cam.ac.uk> <Pine.LNX.4.61.0511052246480.12843@scrub.home> <Pine.LNX.4.64.0511052155270.5813@hermes-1.csi.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0511052155270.5813@hermes-1.csi.cam.ac.uk>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 05 2005, Anton Altaparmakov wrote:
> My suggestion was to tell the driver that you have done changes behind
> its back so it will be happy.

I didn't know that this was a possibility and, as a luser, I would love
to have this functionality as I frequently need to use HFS+ filesystems
with Linux.

Perhaps, with big, fat warnings in the configure help (defaulting for
the safest thing) it could be an option, while we don't have the journal
replay that Roman mentioned.


Regards, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
