Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263775AbUA0Sgz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 13:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263832AbUA0Sgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 13:36:55 -0500
Received: from ns.suse.de ([195.135.220.2]:56212 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263775AbUA0Sgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 13:36:52 -0500
To: Rui Saraiva <rmps@joel.ist.utl.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Trailing blanks in source files
References: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 27 Jan 2004 19:34:02 +0100
In-Reply-To: <Pine.LNX.4.58.0401271544120.27260@joel.ist.utl.pt.suse.lists.linux.kernel>
Message-ID: <p73bropfdgl.fsf@nielsen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Saraiva <rmps@joel.ist.utl.pt> writes:

> 	It seems that many files [1] in the Linux source have lines with
> trailing blank (space and tab) characters and some even have formfeed
> characters. Obviously these blank characters aren't necessary.
> 
> 	I wonder if it is a waste of time to send patches that clean the
> source? Those patches will only remove those trailing blank characters and
> will be splitted by maintainer.

A lot of people will hate you for that because you'll break their external
patches without any good reason.

Don't do it.

I'm sure there are lots of other areas where good clean up can be done
without causing problems.

-Andi
