Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263085AbTDFVDe (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 17:03:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263086AbTDFVDe (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 17:03:34 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:2269 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263085AbTDFVDd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 17:03:33 -0400
Date: Mon, 07 Apr 2003 09:12:00 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: PATCH: Fixes for ide-disk.c
In-reply-to: <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1049663520.8403.26.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
 <1049570711.3320.2.camel@laptop-linux.cunninghams>
 <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

I've just reread your message. Isn't it used as a lock at the moment?
IIRC, you get a BUG if you try to use the driver while its blocked.
Perhaps that's where I'm getting confused.

Regards,

Nigel

On Mon, 2003-04-07 at 03:03, Alan Cox wrote:
> Blocked is a binary power management described state, its not a lock.
> What are you actually trying to do ?


