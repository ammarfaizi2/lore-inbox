Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbTBSNgs>; Wed, 19 Feb 2003 08:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbTBSNgs>; Wed, 19 Feb 2003 08:36:48 -0500
Received: from gjs.xs4all.nl ([80.126.25.16]:25761 "EHLO mail.gjs.cc")
	by vger.kernel.org with ESMTP id <S268896AbTBSNgr>;
	Wed, 19 Feb 2003 08:36:47 -0500
From: GertJan Spoelman <kl@gjs.cc>
To: Luis Miguel Garcia <ktech@wanadoo.es>, linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.5.62 kernel
Date: Wed, 19 Feb 2003 14:46:29 +0100
User-Agent: KMail/1.5
References: <20030217173210.626efa05.ktech@wanadoo.es> <3E5246A5.6020003@nyc.rr.com> <20030218135259.3c8a3009.ktech@wanadoo.es>
In-Reply-To: <20030218135259.3c8a3009.ktech@wanadoo.es>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200302191446.29340.kl@gjs.cc>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 18 February 2003 13:52, Luis Miguel Garcia wrote:
> hello:
>
> Yes, it was missing module-init-tools. Now I have my kernel compiled but
> when I try to boot, I can only see
>
> Uncompressing Kernel... booting linux....
>
> and then I cannot see nothing more but the HD is going up and down during
> half a minute, so I think something is happening but my screen is not
> updating.
>
> What can I test in order to boot my system?
>
> I'm behing a Sony Vaio N505-VE laptop.

Maybe the message below applies to you too.

On Wed, Feb 19, 2003 at 10:52:47AM +0100, Duncan Sands wrote:
> This is becoming a FAQ!  Did you enable the console in your .config?
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> Most likely you chose to compile the input system as a module, which
> caused the console options to be autohorribly deselected.  Just say 'y'
> for the input subsystem, at which point the console options will reappear,
> letting you select them.
> I hope this helps,
> Duncan.

-- 

    GertJan
