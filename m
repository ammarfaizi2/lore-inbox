Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbUABAo3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 19:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbUABAo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 19:44:29 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:12432 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262050AbUABAoZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 19:44:25 -0500
Date: Fri, 2 Jan 2004 00:43:37 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: Erik Andersen <andersen@codepoet.org>
cc: Andries Brouwer <aebr@win.tue.nl>, Andrew Morton <akpm@osdl.org>,
       Neale Banks <neale@lowendale.com.au>, linux-kernel@vger.kernel.org
Subject: Re: chmod of active swap file blocks
In-Reply-To: <20040101214051.GA19390@codepoet.org>
Message-ID: <Pine.LNX.4.56.0401020042420.1343@fogarty.jakma.org>
References: <Pine.LNX.4.56.0312291719160.16956@fogarty.jakma.org>
 <Pine.LNX.4.05.10401011905310.31562-100000@marina.lowendale.com.au>
 <20040101021241.31830e30.akpm@osdl.org> <20040101151027.A2411@pclin040.win.tue.nl>
 <20040101214051.GA19390@codepoet.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jan 2004, Erik Andersen wrote:

> Perhaps swapon should automagically do a chmod and chown on all
> swapfiles, unless specifically asked to be wildly insecure (perhaps
> with a -W option -- wildly insecure swapfile permissions are
> considered acceptable)....

There's no sane reason to have open swap files, so yes, above 
behaviour would be good.

>  -Erik

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
A prisoner of war is a man who tries to kill you and fails, and then
asks you not to kill him.
		-- Sir Winston Churchill, 1952
