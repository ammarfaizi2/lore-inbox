Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751221AbWAUXZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbWAUXZz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 18:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751222AbWAUXZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 18:25:55 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:23306 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751221AbWAUXZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 18:25:54 -0500
Date: Sun, 22 Jan 2006 00:25:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cc-version not available to change EXTRA_CFLAGS
Message-ID: <20060121232542.GA19480@mars.ravnborg.org>
References: <20060121180805.GA15761@suse.de> <20060121225728.GA13756@mars.ravnborg.org> <20060121231539.GA23789@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060121231539.GA23789@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 12:15:39AM +0100, Olaf Hering wrote:
> Will you include the reiserfs change with a check for earlier then 4.0
> or 4.1 or should I send a separate patch?

Please submit as a separate patch. I try to keep non-kbuild stuff out of
the kbuild tree. This make is less confusing.

I will not commit this until sometime tomorrow - I have to set up
something so I can track bugfixes and enhancements in parallel.
This is 2.6.17 material IMO in kbuild land except if we want this in for
reiserfs before 2.6.17.

I try to be rather strict about bug-fixes versus enhancements in kbuild.
The latest unexpected breakage shows how easy it is to introduce
unexpected errors in someones build :-(

	Sam
