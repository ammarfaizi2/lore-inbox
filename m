Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTF0PSA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 11:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTF0POu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 11:14:50 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:33806 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264634AbTF0POJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 11:14:09 -0400
Subject: Re: [BENCHMARK] O1int patch with contest
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <200306280041.47619.kernel@kolivas.org>
References: <200306280041.47619.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1056727700.584.3.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 27 Jun 2003 17:28:20 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-06-27 at 16:41, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I've had some (off list) requests to see if the interactivity patch I posted 
> shows any differences in contest. To be honest I wasn't sure it would, and 
> this is not quite what I expected. Below is a 2.5.73-mm1 patched with 
> patch-O1int-0306271816 (2.5.73-O1i) compared to 2.5.73-mm1 with contest 
> (http://contest.kolivas.org).

These are good news, indeed. The patch is getting better and better, but
I'm still seeing XMMS audio skips when clicking on a URL inside
Evolution (and using Konqueror as my web browser), and sometimes when
moving windows around.

Also, it seems that nicing the X server to -20 causes it to get CPU at
discontinuous bursts, causing window movement to be somewhat jerky. The
overall feeling for the X server is better at a default nice of 0. Isn't
this curious?

