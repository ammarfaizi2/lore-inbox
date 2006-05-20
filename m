Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWETVlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWETVlL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 17:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWETVlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 17:41:11 -0400
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:38052 "EHLO
	stout.engsoc.carleton.ca") by vger.kernel.org with ESMTP
	id S932389AbWETVlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 17:41:10 -0400
Date: Sat, 20 May 2006 17:41:01 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: John Richard Moser <nigelenki@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IA-32 on x86-64
Message-ID: <20060520214101.GA8413@tachyon.int.mcmartin.ca>
References: <446F138F.4020801@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <446F138F.4020801@comcast.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 20, 2006 at 09:03:11AM -0400, John Richard Moser wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Does anyone know how to check if I'm running an IA-32 process on x86-64?

is_compat_task()

>  More importantly, how do I tell how big the user VM space is for
> current?  Like 3GiB for x86 and who knows what (87GiB?  192GiB?) for
> x86-64 and however much for sparc/ppc ....

TASK_SIZE

You should probably do your own work instead of posting questions everytime
you hit something you'd have to do a little bit of searching for.

--
