Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262224AbVGMWYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbVGMWYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261539AbVGMWJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:09:24 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:58573 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262717AbVGMWHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:07:05 -0400
Date: Thu, 14 Jul 2005 00:01:23 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Greg KH <gregkh@suse.de>
Cc: ralf@linux-mips.org, netdev@vger.kernel.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [05/11] SMP fix for 6pack driver
Message-ID: <20050713220123.GA3292@electric-eye.fr.zoreil.com>
References: <20050713184130.GA9330@kroah.com> <20050713184331.GG9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184331.GG9330@kroah.com>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> :
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> 
> Drivers really only work well in SMP if they actually can be selected.
> This is a leftover from the time when the 6pack drive only used to be
> a bitrotten variant of the slip driver.

Is the guideline above from 28/04/2005 obsoleted ?

 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short,
   something critical.

--
Ueimor
