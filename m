Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262538AbUDKXuG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 19:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbUDKXuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 19:50:06 -0400
Received: from 80-218-57-148.dclient.hispeed.ch ([80.218.57.148]:56069 "EHLO
	ritz.dnsalias.org") by vger.kernel.org with ESMTP id S262538AbUDKXuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 19:50:02 -0400
From: Daniel Ritz <daniel.ritz@gmx.ch>
Reply-To: daniel.ritz@gmx.ch
To: Tim Blechmann <TimBlechmann@gmx.net>
Subject: Re: [linux-audio-user] snd-hdsp+cardbus+M6807 notebook=distortion -- First good news
Date: Mon, 12 Apr 2004 01:45:22 +0200
User-Agent: KMail/1.5.2
Cc: Ivica Ico Bukvic <ico@fuse.net>, "'Thomas Charbonnel'" <thomas@undata.org>,
       ccheney@debian.org, linux-pcmcia@lists.infradead.org,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>
References: <200404100347.56786.daniel.ritz@gmx.ch> <20040411142527.A29837@flint.arm.linux.org.uk> <20040411180831.6e2432d3@laptop>
In-Reply-To: <20040411180831.6e2432d3@laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404120145.22679.daniel.ritz@gmx.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 11 April 2004 18:08, Tim Blechmann wrote:
> hi all,
> 
> > > The 06 to 04 may be the critical element as even when I have
> > > everything properly running in Win32, when I alter this number the
> > > distortion returns
> > 
> > $ setpci -s a.0 0xc9.b
> > 
> > will display the value of this register under Linux, and:
> > 
> > $ setpci -s a.0 0xc9.b=value
> i tried to read these registers on my cardbus bridge but on my system
> the registers are zero (00) ... 
> i tried to set these registers to the values ico had on his machines,
> but it seems that i'm not able to set them ... if i read the registers
> after setting them, they are still zero ...

that register is specific to TI/EnE bridges. if i remember correctly, you
have a o2micro 6933, right?

