Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312267AbSCTXJv>; Wed, 20 Mar 2002 18:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312266AbSCTXJt>; Wed, 20 Mar 2002 18:09:49 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:25484 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S312267AbSCTXJV>; Wed, 20 Mar 2002 18:09:21 -0500
Date: Thu, 21 Mar 2002 00:09:10 +0100
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
Message-ID: <20020320230910.GA6462@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020319225609.A12655@ucw.cz> <20020320065425.D27F3DD1C@mail.medav.de> <20020320221514.GB23957@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Daniel Kobras <kobras@linux.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2002 at 11:15:14PM +0100, Pavel Machek wrote:
> I do not think we are using PM3:sleep in noflushd, but we even
> could. AFAICT, ide layer resets interface if it does not respond.

It does, but only after a rather longish timeout, and a couple of IDE
errors in the syslog.  Nothing I'd like to scare users with, so noflushd
issues standby (PM2).

Regards,

Daniel.

