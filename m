Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751675AbWADKzs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751675AbWADKzs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 05:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWADKzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 05:55:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:29667 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751669AbWADKzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 05:55:48 -0500
Date: Wed, 4 Jan 2006 11:55:46 +0100
From: Jan Blunck <jblunck@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Dave Jones <davej@redhat.com>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Eliminate __attribute__ ((packed)) warnings for gcc-4.1
Message-ID: <20060104105546.GA10207@hasse.suse.de>
References: <20060103113045.GB24131@hasse.suse.de> <20060104022530.GA29784@redhat.com> <Pine.LNX.4.61.0601041014570.29257@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0601041014570.29257@yvahk01.tjqt.qr>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, Jan Engelhardt wrote:

> >What's with the funky placement of ; ?
> >The rest of the struct looks sensible.
> >
> Looks like a simple s/__attribute__((packed))// rather than
> s/\s+__attribute__((packed))/;

Yeah, seems that I was too lazy. I'll do better next time ;)

Andrew, I'll resend a whitespace-beautified version.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
