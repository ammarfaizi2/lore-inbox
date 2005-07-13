Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVGMRj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVGMRj1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 13:39:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261922AbVGMRhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 13:37:43 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:62644 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261995AbVGMRek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 13:34:40 -0400
Subject: RE: [ANNOUNCE] Interbench v0.20 - Interactivity benchmark
From: Lee Revell <rlrevell@joe-job.com>
To: szonyi calin <caszonyi@yahoo.com>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, caszonyi@rdslink.ro
In-Reply-To: <20050713112710.60204.qmail@web52902.mail.yahoo.com>
References: <20050713112710.60204.qmail@web52902.mail.yahoo.com>
Content-Type: text/plain
Date: Wed, 13 Jul 2005 13:34:37 -0400
Message-Id: <1121276077.4435.50.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 13:27 +0200, szonyi calin wrote:
> I have the following problem with audio:
> Xmms is running with threads for audio and spectrum
> analyzer(OpenGL).
> The audio eats 5% cpu, the spectrum analyzer about 80 %. The
> problem is that sometimes the spectrum analyzer is eating all of
> the cpu while the audio is skipping. Xmms is version 1.2.10
> kernel is vanilla, latest "stable" version 2.6.12, suid root.
> 
> Does your benchmark simultes this kind of behaviour ? 

That's just a broken app, the kernel can't do anything about it.  XMMS
should not be running the spectrum analyzer thread at such a high
priority as to interfere with the audio thread.

Lee

