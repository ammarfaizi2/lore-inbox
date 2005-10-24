Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751126AbVJXQCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbVJXQCA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 12:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbVJXQCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 12:02:00 -0400
Received: from mail.fieldses.org ([66.93.2.214]:12420 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1751126AbVJXQCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 12:02:00 -0400
Date: Mon, 24 Oct 2005 12:01:58 -0400
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc5 apm suspend failure--ALSA patch?
Message-ID: <20051024160158.GK9154@fieldses.org>
References: <20051023184202.GB10037@fieldses.org> <s5hu0f72q8h.wl%tiwai@suse.de> <20051024153526.GH9154@fieldses.org> <s5hoe5f9b8n.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hoe5f9b8n.wl%tiwai@suse.de>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2005 at 05:38:00PM +0200, Takashi Iwai wrote:
> At Mon, 24 Oct 2005 11:35:26 -0400,
> J. Bruce Fields wrote:
> > And on boot I see this:
> > 
> > Oct 22 11:44:45 puzzle kernel: ALSA device list:
> > Oct 22 11:44:45 puzzle kernel:   #0: Virtual MIDI Card 1
> 
> Ah, that's it.  The patch I sent should fix Oops, then.

Yep, that did it, thanks.  Will this be in 2.6.14?

--b.
