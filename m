Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263827AbTKRXkO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 18:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263828AbTKRXkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 18:40:13 -0500
Received: from users.linvision.com ([62.58.92.114]:40411 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S263827AbTKRXkL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 18:40:11 -0500
Date: Wed, 19 Nov 2003 00:40:09 +0100
From: Erik Mouw <erik@bitwizard.nl>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.6.0-test9] sleep from invalid function (ALSA related?)
Message-ID: <20031118234009.GA12796@bitwizard.nl>
References: <20031113113316.GA30460@bitwizard.nl> <s5hk763jj3e.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk763jj3e.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 14, 2003 at 12:16:37PM +0100, Takashi Iwai wrote:
> At Thu, 13 Nov 2003 12:33:16 +0100,
> Erik Mouw wrote:
> > I compiled 2.6.0-test9 on my desktop last night. Not too many problems
> > so far, but this debug trace caught my attention:
> (snip)
> > It looks ALSA related to me, the soundcard I use is a Midiman
> > Audiophile 2496, which uses the ice1712 driver.
> 
> the attached patch should fix.
> please give a try.

Yes, that fixes it indeed, no debug warnings on load/unload. Thanks!


Erik

-- 
----  Erik Mouw  ----  www.bitwizard.nl  ----  +31 15 2600 998  ----
