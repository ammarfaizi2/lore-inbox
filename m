Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbTESVU0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 17:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTESVUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 17:20:25 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:7183 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262934AbTESVUY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 17:20:24 -0400
Date: Mon, 19 May 2003 23:33:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, torvalds@transmeta.com,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove 'strchr' warning from reiserfs
Message-ID: <20030519213315.GA1069@mars.ravnborg.org>
Mail-Followup-To: Stephen Hemminger <shemminger@osdl.org>,
	Sam Ravnborg <sam@ravnborg.org>, torvalds@transmeta.com,
	reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
References: <20030517191611.GA10417@mars.ravnborg.org> <20030519124712.2c4b692d.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030519124712.2c4b692d.shemminger@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 12:47:12PM -0700, Stephen Hemminger wrote:
> 
> Is this gcc behaviour documented anywhere?

I dropped a mail to gcc-bugs - the reply was:

=======
The kernel is a special case; GCC is entitled to assume the existence of
standard C library functions.
=======

So when messing with standard functions we may expect a few suprises,
which I think is fair enough.

	Sam
