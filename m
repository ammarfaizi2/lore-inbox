Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161010AbWARVrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161010AbWARVrQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 16:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161012AbWARVrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 16:47:15 -0500
Received: from mx.pathscale.com ([64.160.42.68]:23780 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030478AbWARVrM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 16:47:12 -0500
Subject: Re: Linux 2.6.16-rc1
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060118212022.GA15828@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	 <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org>
	 <20060118085936.4773dd77.khali@linux-fr.org>
	 <20060118091543.GA8277@mars.ravnborg.org>
	 <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr>
	 <20060118191247.62cc52cd.khali@linux-fr.org>
	 <20060118203231.GA14340@mars.ravnborg.org>
	 <1137617677.4757.90.camel@serpentine.pathscale.com>
	 <20060118212022.GA15828@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 13:47:07 -0800
Message-Id: <1137620827.4757.106.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 22:20 +0100, Sam Ravnborg wrote:

> Much better - thanks!
> I will push out a new path tomorrow.

Just to be sure, something like this will work well, and bring you down
to one program executed per test:

        $(findstring /,$(shell gcc -print-file-name=libcurses.so))

You have to check for a "/" in the output, as -print-file-name will
print its input unmodified if it can't actually find the file you
specify.

	<b

