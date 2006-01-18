Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbWARUyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbWARUyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030427AbWARUyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:54:43 -0500
Received: from mx.pathscale.com ([64.160.42.68]:50395 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1030448AbWARUyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:54:43 -0500
Subject: Re: Linux 2.6.16-rc1
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060118203231.GA14340@mars.ravnborg.org>
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	 <43CD67AE.9030501@eyal.emu.id.au> <20060117232701.GA7606@mars.ravnborg.org>
	 <20060118085936.4773dd77.khali@linux-fr.org>
	 <20060118091543.GA8277@mars.ravnborg.org>
	 <Pine.LNX.4.61.0601181421210.19392@yvahk01.tjqt.qr>
	 <20060118191247.62cc52cd.khali@linux-fr.org>
	 <20060118203231.GA14340@mars.ravnborg.org>
Content-Type: text/plain
Date: Wed, 18 Jan 2006 12:54:37 -0800
Message-Id: <1137617677.4757.90.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 21:32 +0100, Sam Ravnborg wrote:

> But in the lxdialog case we need to execute the link step, because
> what we really try to do is to check if gcc can find a specific
> library in the search path.

Will -print-file-name not do the trick for you?

$ gcc -print-file-name=libcurses.so | grep -q /
$ echo $?
0
$ gcc -print-file-name=libfoobar.a | grep -q /
$ echo $?
1

	<b

