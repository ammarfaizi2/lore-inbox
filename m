Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUFSSCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUFSSCS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 14:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUFSSCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 14:02:18 -0400
Received: from smtp-out6.xs4all.nl ([194.109.24.7]:40459 "EHLO
	smtp-out6.xs4all.nl") by vger.kernel.org with ESMTP id S264386AbUFSSCR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 14:02:17 -0400
Date: Sat, 19 Jun 2004 20:01:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.local
To: Jari Ruusu <jariruusu@users.sourceforge.net>
cc: Sam Ravnborg <sam@ravnborg.org>, 4Front Technologies <dev@opensound.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
In-Reply-To: <40D46B97.B82A439E@users.sourceforge.net>
Message-ID: <Pine.LNX.4.58.0406191952520.10292@scrub.local>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay>
 <40D23701.1030302@opensound.com> <20040618204655.GA4441@mars.ravnborg.org>
 <40D46B97.B82A439E@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 19 Jun 2004, Jari Ruusu wrote:

> > So you seems to be bitten by a distributor starting to use a new
> > facility in kbuild.
> 
> SUSE folks made a silly mistake and broke stuff. It was even more silly for
> them to try to submit that breakage to mainline.

Letting the symlink point to the build directory is the only sane option. 
What's missing is that the native kernel tree itself should generate a 
small Makefile in the build directory.
SuSE did the right thing, it now just needs proper integration.

bye, Roman
