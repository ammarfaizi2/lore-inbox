Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTKLAqN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 19:46:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTKLAqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 19:46:13 -0500
Received: from zero.aec.at ([193.170.194.10]:1811 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S261406AbTKLAqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 19:46:10 -0500
To: Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2 TB partition support
From: Andi Kleen <ak@muc.de>
Date: Wed, 12 Nov 2003 01:45:43 +0100
In-Reply-To: <QR40.39P.53@gated-at.bofh.it> (Bernd Schubert's message of
 "Wed, 12 Nov 2003 01:30:37 +0100")
Message-ID: <m3d6bybeiw.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <QugF.3Mq.7@gated-at.bofh.it> <Qwit.771.11@gated-at.bofh.it>
	<QR40.39P.53@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Schubert <Bernd.Schubert@tc.pci.uni-heidelberg.de> writes:

> Are 2TB possible with an unpatched 2.4.x 64bit-AMD64 kernel? The
> partion is supposed to be reiserfs. I read an about 2 years old
> discussion about this and Hans Reiser statet that the maximum size is
> about 2GB. Unfortunality I don't know what this 'about' depends on.
> Furthermore our server for this will be an Opteron and so perhaps this
> limit is much higher on 64bit systems.

In theory yes, but note that nobody tested the drivers for 64bit cleanness 
in block numbers. I would do careful testing first if your block driver supports 
>2TB.

-Andi
