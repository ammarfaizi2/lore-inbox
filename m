Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751630AbVLFESq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630AbVLFESq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbVLFESp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:18:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:32944 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751629AbVLFESo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:18:44 -0500
Date: Tue, 6 Dec 2005 04:18:38 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Dave Airlie <airlied@gmail.com>, David Woodhouse <dwmw2@infradead.org>,
       arjan@infradead.org, andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206041838.GH27946@ftp.linux.org.uk>
References: <21d7e9970512051610n1244467am12adc8373c1a4473@mail.gmail.com> <4394DA1D.3090007@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4394DA1D.3090007@am.sony.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:23:57PM -0800, Tim Bird wrote:
> I meant "handled in the worst possible way by
> the kernel developers".  It *is* possible to define
> stable APIs and have them used successfully.
> 
> POSIX is not the greatest example, but it seems
> to work OK.  I realize that drivers are more
> tightly bound to the kernel than are libraries
> or applications, but sheesh, this is not rocket
> science.

You do realize that any attempt to create a stable API (which would
reduce the amount of exported symbols by factor of 50 to start with)
will have the parties currently advocating interface stability screaming
bloody murder?

Who do you think had been responsible for current mess?  The people
who kept adding random exports with no rationale beyond "it's needed
for our code", that's who...
