Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266893AbUBMKXh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 05:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266894AbUBMKXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 05:23:36 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:13329 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266893AbUBMKXf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 05:23:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Fri, 13 Feb 2004 12:22:17 +0200
X-Mailer: KMail [version 1.4]
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <20040209115852.GB877@schottelius.org> <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk> <200402131103.10366.robin.rosenberg.lists@dewire.com>
In-Reply-To: <200402131103.10366.robin.rosenberg.lists@dewire.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402131222.17656.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 12:03, Robin Rosenberg wrote:
> On Friday 13 February 2004 03.29, you wrote:
> > On Fri, Feb 13, 2004 at 02:16:53AM +0100, Robin Rosenberg wrote:
> > > Yes, so ext3&co. should be equipped with charset options just the other
> > > so it can be fixed by the user or in some cases the mount tools.
> > >
> > > Is there a place to store character set information in these file
> > > systems?
> >
> > Bullshit.  Just as there is no timezone common for all users, there is no
> > charset common for all of them.  Charset of _machine_ doesn't make any
> > sense at all - toy operating systems nonwithstanding.
>
> For us using toy languages, we see characters in filenames, not byte
> sequences, and if whenever possible users should see the same name
> regardless of locale.

Al says that there can be a hundred of users on the box _simultaneously_,
each with different locale. fs should store filenames
in locale-agnostic way.
-- 
vda
