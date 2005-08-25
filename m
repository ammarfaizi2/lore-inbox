Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVHYSpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVHYSpx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 14:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932355AbVHYSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 14:45:53 -0400
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:62404 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S932354AbVHYSpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 14:45:52 -0400
Date: Thu, 25 Aug 2005 14:45:51 -0400
From: Christopher Faylor <me@cgf.cx>
To: linux-kernel@vger.kernel.org,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Chris du Quesnay <duquesnay@hotmail.com>
Subject: Re: Building the kernel with Cygwin
Message-ID: <20050825184551.GA32464@trixie.casa.cgf.cx>
References: <BAY14-F20DDBBC08EC1461957F455BAAB0@phx.gbl> <Pine.LNX.4.61.0508251258330.4160@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0508251258330.4160@chaos.analogic.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2005 at 01:05:24PM -0400, linux-os (Dick Johnson) wrote:
>On Thu, 25 Aug 2005, Chris du Quesnay wrote:
>>The scripts/basic directory contains a fixdep.exe after the make is
>>run.  There is no fixdep file.  I tried renaming the fixdep.exe to
>>fixdep, but that also resulted in the same make error.
>
>Ah yes! The Makefile will not execute 'fixdep.exe` it executes 'fixdep'
>--hard coded.  I don't know how well cygwin emulates a Unix
>environment, but maybe you can use an alias???  ..  Like...  alias
>fixdep='fixdep.exe'

How about a symlink?

ln -s fixdep.exe fixdep

cgf
--
Christopher Faylor			spammer? ->	aaaspam@sourceware.org
Cygwin Co-Project Leader				aaaspam@duffek.com
TimeSys, Inc.
