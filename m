Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289348AbSBNCAB>; Wed, 13 Feb 2002 21:00:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289353AbSBNB7w>; Wed, 13 Feb 2002 20:59:52 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:57847
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S289348AbSBNB7g>; Wed, 13 Feb 2002 20:59:36 -0500
Date: Wed, 13 Feb 2002 17:59:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_sync livelock fix
Message-ID: <20020214015947.GD335@matchmail.com>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213170030.12448F-100000@gatekeeper.tmr.com> <E16b9jW-0002QL-00@starship.berlin> <3C6B06E5.F6A7AD9F@zip.com.au> <E16bA59-0002Qa-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16bA59-0002Qa-00@starship.berlin>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2002 at 01:49:03AM +0100, Daniel Phillips wrote:
> Dangerous advocacy of the broken SuS semantics for sync, has to be stamped
> out before it spreads ;-)

Daniel,

You seem to be taking both sides of this argument.

Do you agree that sync should be changed to a checkpoint so that doesn't
block for dirty data created *after* sync was called?
