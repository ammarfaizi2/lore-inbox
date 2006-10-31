Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423797AbWJaSyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423797AbWJaSyu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423796AbWJaSyt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:54:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:59407 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1423797AbWJaSys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:54:48 -0500
Date: Tue, 31 Oct 2006 19:54:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Martin Bligh <mbligh@google.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
Message-ID: <20061031185448.GT27968@stusta.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061030213454.8266fcb6.akpm@osdl.org> <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org> <45477668.4070801@google.com> <20061031183319.GR27968@stusta.de> <454797CB.7030404@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454797CB.7030404@google.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 10:36:59AM -0800, Martin Bligh wrote:
> Adrian Bunk wrote:
> >On Tue, Oct 31, 2006 at 08:14:32AM -0800, Martin J. Bligh wrote:
> >
> >>...
> >>PS. I still think -Werror is a good plan. But I acknowledge that's
> >>fairly extreme.
> >
> >
> >Note that this would imply options like -Wno-unused-function and
> >-Wno-unused-variable (unless you _really_ want to add a few thousand 
> >#ifdef's to the kernel).
> 
> I don't think so. We already do this inside Google, and it works fine.
> I just had about 20 stupid warnings to fix up for 2.6.18. Might depend
> which gcc it was, but 4.1 seemed to work OK with that, at least.

This might be true if you are only using typical configurations that are 
already low on warnings.

The fun begins if you use settings like CONFIG_PCI=n or
CONFIG_PROC_FS=n .

> M.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

