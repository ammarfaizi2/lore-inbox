Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265085AbUFGVan@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbUFGVan (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:30:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUFGVam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:30:42 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28963 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S265077AbUFGVa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:30:26 -0400
Date: Mon, 7 Jun 2004 23:36:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: how to configure/build a kernel in a separate directory?
Message-ID: <20040607213605.GA14963@mars.ravnborg.org>
Mail-Followup-To: "Robert P. J. Day" <rpjday@mindspring.com>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406071653200.21938@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 05:00:26PM -0400, Robert P. J. Day wrote:
> 
>   (i originally posted this to the "make" mailing list, but i figured 
> someone here *must* have done this before.)
> 
>   is there an easy way to configure/build one or both of a 2.4 and 2.6 
> kernel in a totally separate directory from the source directory itself?

For 2.4 you are out of luck. At least I do not know of any patch that
should allow you to do that with current 2.4 kernel.

For 2.6 you just use (executed in root of kernel src):

make O=dir/to/put/output target

Se make help + README for a bit more info.

	Sam
