Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266512AbUI0PwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266512AbUI0PwU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266513AbUI0PwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:52:20 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:3014 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266512AbUI0PwO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:52:14 -0400
Subject: Re: 2.6.8.1: xtime value may become incorrect
From: john stultz <johnstul@us.ibm.com>
To: Vladimir Grouzdev <vladimir.grouzdev@Jaluna.COM>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <41583036.9010907@jaluna.com>
References: <41583036.9010907@jaluna.com>
Content-Type: text/plain
Message-Id: <1096300338.4249.16.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 27 Sep 2004 08:52:18 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-27 at 08:22, Vladimir Grouzdev wrote:
>     The xtime value may become incorrect when the
>     update_wall_time(ticks) function is called with "ticks" > 1.
>     In such a case, the xtime variable is updated multiple times
>     inside the loop but it is normalized only once outside of
>     the loop.

Vladimir, 
	This looks like a good patch to me. If no one else has any complaints,
send it on to Andrew.

thanks!
-john

