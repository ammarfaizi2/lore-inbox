Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbSK2JNc>; Fri, 29 Nov 2002 04:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSK2JNc>; Fri, 29 Nov 2002 04:13:32 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:49866 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266983AbSK2JNc> convert rfc822-to-8bit; Fri, 29 Nov 2002 04:13:32 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Radeon DRM oops in 2.4.20-rc4-ac1
Date: Fri, 29 Nov 2002 10:20:17 +0100
User-Agent: KMail/1.4.3
Organization: WOLK - Working Overloaded Linux Kernel
Cc: Jens-Christian Skibakk <jens@cultus.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200211291020.17123.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens-Christian,

> Now I can start the X-Window system, and glxinfo report direct redering 
> as enabled.
> But when I test the glxgears I get Illegal instruction, the same error 
> also happens for tuxracer.
> If I turn the DRI of in the XF86Config-4 file, glxgears runs fine, but 
> without HW redering.
hmm, seems the Radeon code is somewhat buggy. I have a Rage128 chipset and 
that is working fine after the fix applied.

Consider writing Arjan van de Ven, he did the code :)

ciao, Marc
