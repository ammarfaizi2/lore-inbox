Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbUK0VFr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbUK0VFr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 16:05:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUK0VFr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 16:05:47 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:20093 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261339AbUK0VFf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 16:05:35 -0500
Date: Sat, 27 Nov 2004 22:06:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Dan Kegel <dank@kegel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Message-ID: <20041127210651.GC7857@mars.ravnborg.org>
Mail-Followup-To: Dan Kegel <dank@kegel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41A8D8CA.9090309@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41A8D8CA.9090309@kegel.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2004 at 11:43:06AM -0800, Dan Kegel wrote:
> >
> >for me i would install all those kernel realted files into 
> >the well known /lib/modules/<kernel-version>. 
> 
> IMHO the script should let you install the headers
> wherever you like.  In particular, in crosstool,
> I would like to install the headers somewhere like
> /opt/crosstool/$TARGET/include rather than /usr/include.

Agreed and trivial to do.
One should recall that for current kernel the following path is valid:
/lib/modules/`uname -r`/source/include/*

This is valid for 2.6.7 or something.

	Sam
