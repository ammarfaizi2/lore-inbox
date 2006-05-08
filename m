Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbWEHUFz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbWEHUFz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:05:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWEHUFz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:05:55 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:48400 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751299AbWEHUFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:05:54 -0400
Date: Mon, 8 May 2006 22:05:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Hua Zhong <Hua.Zhong@teneros.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Build error in modpost.c for latest git
Message-ID: <20060508200546.GA4340@mars.ravnborg.org>
References: <384422E6306C7D439E6C327F5FCFFDCE011C236F@EXCH-US02.nuitysystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <384422E6306C7D439E6C327F5FCFFDCE011C236F@EXCH-US02.nuitysystems.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 08, 2006 at 11:34:35AM -0700, Hua Zhong wrote:
> scripts/mod/modpost.c: In function `check_sec_ref':
> scripts/mod/modpost.c:716: error: cast to union type from type not
> present in union
> make[2]: *** [scripts/mod/modpost.o] Error 1
> make[1]: *** [scripts/mod] Error 2
> make: *** [scripts] Error 2

I have just asked Linus to revert the bogus commit.
Sorry for this!

The bogus commit is:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed

	Sam
