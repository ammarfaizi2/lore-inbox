Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268003AbUIJWtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268003AbUIJWtQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIJWtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:49:15 -0400
Received: from the-village.bc.nu ([81.2.110.252]:24242 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268003AbUIJWsN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:48:13 -0400
Subject: Re: CMedia CM9739 - sneaked in via some cheap via motherboards
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040910222155.GA19158@lkcl.net>
References: <20040910222155.GA19158@lkcl.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094852761.18235.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 10 Sep 2004 22:46:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-10 at 23:21, Luke Kenneth Casson Leighton wrote:
> it _almost_ works - it just doesn't recognise the PCM slider.
> alsamixer can't set PCM
> kmix and kamix don't even _show_ PCM.
> 
> which ain't much cop, really, cos no PCM means "no sound matey".

If I remember rightly the PCM on these is mute only. We fixed that for
OSS it may be it didnt get propogated into ALSA or this is some new
horrible variant. What we don't have is a fast software volume control
in OSS, dunno if ALSA has one.

