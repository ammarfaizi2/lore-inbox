Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbTDFPuw (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 11:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbTDFPuw (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 11:50:52 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28814
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263022AbTDFPuQ (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 11:50:16 -0400
Subject: Re: PATCH: Fixes for ide-disk.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1049570711.3320.2.camel@laptop-linux.cunninghams>
References: <1049527877.1865.17.camel@laptop-linux.cunninghams>
	 <1049561200.25700.7.camel@dhcp22.swansea.linux.org.uk>
	 <1049570711.3320.2.camel@laptop-linux.cunninghams>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049641400.963.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 16:03:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-04-05 at 20:25, Nigel Cunningham wrote:
> Hi.
> 
> On Sun, 2003-04-06 at 04:46, Alan Cox wrote:
> > Drive->blocked is a single bit field. Its not a counting lock. Either
> > we are blocked or not.
> 
> Okay. We need a different solution then, but the problem remains - the
> driver can get multiple, nexted calls to block and unblock. Can it
> become a counting lock?

Blocked is a binary power management described state, its not a lock.
What are you actually trying to do ?

