Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbTJ3DDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 22:03:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262158AbTJ3DDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 22:03:19 -0500
Received: from taco.zianet.com ([216.234.192.159]:62735 "HELO taco.zianet.com")
	by vger.kernel.org with SMTP id S262152AbTJ3DDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 22:03:18 -0500
From: Steven Cole <elenstev@mesatop.com>
To: rob@landley.net, linux-kernel@vger.kernel.org
Subject: Re: Suspend to disk panicked in -test9.
Date: Wed, 29 Oct 2003 19:35:28 -0700
User-Agent: KMail/1.5
References: <200310291857.40722.rob@landley.net>
In-Reply-To: <200310291857.40722.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310291935.28554.elenstev@mesatop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 October 2003 05:57 pm, Rob Landley wrote:
> Unfortunately, while I was writing down the panic on a piece of paper, the
> screen blanking code kicked in while I was still copying down the register
> values.  I remember that the call trace mentioned some variant of a
> write_stuff_to_disk call, but that's not that useful...
>
> When is the last time that the screen blanking code actually accomplished
> something useful?  These days it seems to exist for the purpose of
> destroying panic call traces and annoying people.  (I seem to remember that
> pressing a key used to make it come back, but now we're forced to use the
> input core that no longer seems to be the case...)
>
> I also seem to remember a patch floating by on the list that would make
> console screen blanking go away.  I really think console screen blanking
> NOT being enabled should be the default these days.  Or at the very least,
> when there's a panic it should get shut off.  I'll add looking into that to
> my to-do list, but will probably get to it somewhere around 2009...
>
> Rob

In the meantime, keeping a digital camera close by when testing is a
low tech/high tech solution to this. 

Steven
