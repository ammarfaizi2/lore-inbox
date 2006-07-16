Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946020AbWGPAI5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946020AbWGPAI5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946021AbWGPAI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:08:57 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:54742 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1946020AbWGPAI4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:08:56 -0400
Subject: Re: [stable] Linux 2.6.17.5
From: Marcel Holtmann <marcel@holtmann.org>
To: artusemrys@sbcglobal.net
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, stable@kernel.org
In-Reply-To: <44B9814B.4050103@sbcglobal.net>
References: <20060715030047.GC11167@kroah.com>
	 <20060715032834.GA5944@kroah.com> <20060715042045.GB4322@kroah.com>
	 <44B9814B.4050103@sbcglobal.net>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 02:08:09 +0200
Message-Id: <1153008489.12764.14.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

> >>> We (the -stable team) are announcing the release of the 2.6.17.5 kernel.
> >> Oops, please note that we now have some reports that this patch breaks
> >> some versions of HAL.  So if you're relying on HAL, you might not want
> >> to use this fix just yet (please evaluate the risks of doing this on
> >> your own.)
> > 
> > Hm, HAL 0.5.7 seems to work fine for me.  Anyone else seeing any
> > problems with this version?  Older versions?
> > 
> 
> I'm running 0.5.7 and also see no problems.
> 
> FTR, I'm invoking
> 
> /usr/sbin/hald --daemon=yes --verbose=yes --use-syslog
> 
> and /var/log/messages looks no different than usual (last under 2.6.17.3).

before this got spread around wrong. What I saw was an error window when
logging into Gnome. It said "failed to initialize HAL!". In fact it
seems that this is not a HAL error, it is an error of an application
using HAL and I suspect it was NetworkManager. However with 2.6.17.6 or
2.6.18-rc2 this is no problem anymore.

Regards

Marcel


