Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUBVUPJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 15:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261747AbUBVUPJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 15:15:09 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:51564 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261742AbUBVUPF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 15:15:05 -0500
Date: Sun, 22 Feb 2004 22:15:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <akale@users.sourceforge.net>
Subject: Re: [1/3] kgdb-lite for 2.6.3
Message-ID: <20040222211542.GB14932@mars.ravnborg.org>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Andrew Morton <akpm@zip.com.au>,
	kernel list <linux-kernel@vger.kernel.org>,
	"Amit S. Kale" <akale@users.sourceforge.net>
References: <20040222160417.GA9535@elf.ucw.cz> <20040222202211.GA2063@mars.ravnborg.org> <20040222195444.GB10857@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222195444.GB10857@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +	static char tmpstr[256];
> > 
> > Too? large varriable on the stack.
> 
> Whi one?
> 
> tmpstr is static....
Yup tmpstr, missed the static.

	Sam
