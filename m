Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbUJaUPv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbUJaUPv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:15:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUJaUPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:15:50 -0500
Received: from THUNK.ORG ([69.25.196.29]:16863 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261652AbUJaUPI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:15:08 -0500
Date: Sun, 31 Oct 2004 15:15:01 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
Message-ID: <20041031201500.GA4498@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <4184193A.3060406@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4184193A.3060406@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 06:44:10PM -0400, Jeff Garzik wrote:
> Tim Hockin wrote:
> >So you end up with the mindset of, for example, "if it's text it's XML".
> >You have to parse everything as XML, when simple parsers would be tons
> >faster and simpler and smaller.
> 
> hehehe.  One of the reasons why I like XML is that you don't have to 
> keep cloning new parsers.

.... if you don't mind bloating your application:

% ls -l /usr/lib/libxml2.a
4224 -rw-r--r--  1 root root 4312536 Oct 19 21:55 /usr/lib/libxml2.a

						- Ted

