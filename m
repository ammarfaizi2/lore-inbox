Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264756AbTA1BrF>; Mon, 27 Jan 2003 20:47:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTA1BrF>; Mon, 27 Jan 2003 20:47:05 -0500
Received: from hughes-fe01.direcway.com ([66.82.20.91]:37878 "EHLO
	hughes-fe01.direcway.com") by vger.kernel.org with ESMTP
	id <S264756AbTA1BrF>; Mon, 27 Jan 2003 20:47:05 -0500
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: vojtech@suse.cz, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200301272057.VAA13114@harpo.it.uu.se>
References: <200301272057.VAA13114@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Jan 2003 20:56:07 -0500
Message-Id: <1043718980.1548.3.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-27 at 15:57, Mikael Pettersson wrote:
> However, your version of atkbd.c caused a linkage error due to a
> reference to input_regs() in atkbd_interrupt(). I extracted
> just the changes to atkbd_cleanup() and atkbd_command(), but that
> left me with a dead keyboard on the first test box. In the end
> I kept only the atkbd_cleanup() change and the increased timeout
> for RESET_BAT in atkbd_command() [see below].

Just as another point of reference, I tested your patch with only the
RESET_BAT changes and it worked on my machine as well.

Later,
Tom


