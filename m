Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751229AbWAIM2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751229AbWAIM2v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbWAIM2v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:28:51 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:3797 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751229AbWAIM2u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:28:50 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 15/15] kconf: Check for eof from input stream.
Date: Mon, 9 Jan 2006 12:32:53 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <0ISL003ZI97GCY@a34-mta01.direcway.com> <200601090109.06051.zippel@linux-m68k.org> <1136779153.1043.26.camel@grayson>
In-Reply-To: <1136779153.1043.26.camel@grayson>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091232.56348.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday 09 January 2006 04:59, Ben Collins wrote:

> > Then something is wrong with your automatic build. If the config needs to
> > be updated and stdin is redirected during a kbuild, it will already
> > abort.
>
> And what should be directed into stdin? Nothing. There should be no
> input going into an automated build, exactly because it could produce
> incorrect results.
>
> BTW, this is the automatic build that Debian and Ubuntu both use (in
> Debian's case, used for quite a number of years). So this isn't
> something I whipped up.

That just means Debian's automatic build for the kernel has been broken for 
years. All normal config targets require user input and no input equals 
default input. Only silentoldconfig will abort if input is not available.

bye, Roman
