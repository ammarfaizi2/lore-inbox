Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946109AbWBCX7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946109AbWBCX7a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWBCX7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:59:30 -0500
Received: from smtp.osdl.org ([65.172.181.4]:19941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751503AbWBCX73 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:59:29 -0500
Date: Fri, 3 Feb 2006 15:59:21 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ryan Anderson <ryan@michonline.com>
cc: Larry Finger <Larry.Finger@lwfinger.net>,
       Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
In-Reply-To: <20060203235002.GA5580@mythryan2.michonline.com>
Message-ID: <Pine.LNX.4.64.0602031557380.3969@g5.osdl.org>
References: <43E39932.4000001@lwfinger.net> <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org>
 <43E3A001.7080309@lwfinger.net> <20060203205716.7ed38386@localhost>
 <43E3BF5A.3040305@lwfinger.net> <Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
 <43E3C703.20501@lwfinger.net> <20060203235002.GA5580@mythryan2.michonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Feb 2006, Ryan Anderson wrote:
> 
> You may want to do a "git repack -a -d" to get everything condensed into
> a single pack file.  It will likely take a while to run, however.

Yes. Also remember to throw out the unnecessary files afterwards with 
"git prune-packed". Otherwise you'll have tons of useless small files that 
contain all the same info that you already have in the packfile.

		Linus
