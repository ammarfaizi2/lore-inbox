Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266831AbUG1IHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266831AbUG1IHU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 04:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266814AbUG1ICN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 04:02:13 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:36830 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266827AbUG1H7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 03:59:48 -0400
Date: Wed, 28 Jul 2004 01:00:40 -0700
From: Paul Jackson <pj@sgi.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Interesting race condition...
Message-Id: <20040728010040.172101bf.pj@sgi.com>
In-Reply-To: <ce6e3r$i4n$1@gatekeeper.tmr.com>
References: <Pine.HPX.4.58L.0407231058420.12978@punch.eng.cam.ac.uk>
	<Pine.HPX.4.58L.0407231058420.12978@punch.eng.cam.ac.uk>
	<200407240317.57032.rob@landley.net>
	<ce6e3r$i4n$1@gatekeeper.tmr.com>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill writes:
> When piped. For instance
>    ps eaxf
> does not [show environ], while
>    ps eaxf | cat
> does

Neither the behaviour I'm seeing on my SuSE 8.2 box, and the code I see
in some random procps-3.2.1 I happened to have laying around, agree with
your description.

Rather, both behaviour and code have the 'e' option as a BSD option
(applicable if no '-' option flag) requesting that the environment be
shown, and I get the environment so shown, regardless of whether the
output is a pipe or a tty.

... This subthread is of course off-topic to Rob Landley's
original post - he wasn't using the 'e' option.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
