Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261981AbUFBMAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261981AbUFBMAf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261987AbUFBMAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:00:34 -0400
Received: from styx.suse.cz ([82.208.2.94]:384 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S261981AbUFBMAd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:00:33 -0400
Date: Wed, 2 Jun 2004 14:01:00 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Ingo Oeser <ioe-lkml@rameria.de>, linux-kernel@vger.kernel.org
Subject: Re: [patch - please comment] Support for UTF dead keys in 2.6
Message-ID: <20040602120100.GA1135@ucw.cz>
References: <20040529143421.GA15127@ucw.cz> <200405310809.49059.ioe-lkml@rameria.de> <20040531063149.GD268@ucw.cz> <200405311123.07203.ioe-lkml@rameria.de> <20040531120844.GA1655@ucw.cz> <20040601175732.GA4588@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040601175732.GA4588@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 07:57:32PM +0200, Andries Brouwer wrote:
> On Mon, May 31, 2004 at 02:08:44PM +0200, Vojtech Pavlik wrote:
> 
> > > 	2. Does your patch also support 2 diacritics per character?
> > > 	   This is a requirement for proper Vietnamese support.
> > 
> > No, the patch doesn't add that extension. How is that supposed to work?
> 
> The (or at least, some) support is there already. See dead2.

So, for proper vietnamese support it should be enough to extend the size
of the diacr field to an int in my UTF8 dead key patch?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
