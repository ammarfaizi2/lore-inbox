Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUEQTo2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUEQTo2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 15:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUEQTnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 15:43:01 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:37248
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S262468AbUEQTml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 15:42:41 -0400
From: Rob Landley <rob@landley.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: uspend to Disk - Kernel 2.6.4 vs. r50p
Date: Tue, 11 May 2004 12:49:24 -0500
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040429064115.9A8E814D@damned.travellingkiwi.com> <200405082331.30669.rob@landley.net> <20040509214959.GD13603@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20040509214959.GD13603@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200405111249.24492.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 May 2004 16:49, Pavel Machek wrote:
> Hi!
>
> > > If you suspend, mount
> > > your filesytems, do some work and then resume, you are probably going
> > > to do some pretty nasty corruption. Just don't do that.
> > >
> > > But this problem is shared by swsusp, swsusp2 *and* pmdisk.
> >
> > I know.  I also know that ext2 (and derivatives) have both "last mounted"
> > and "last written to" datestamp fields (other filesystems probably do as
> > well, but I don't use 'em) and it would be really nice to check those as
> > matching what they were when you suspended, and abort the resume if they
> > don't match...
>
> Well, feel free to code that, that will allow us to kill few
> warnings... Or rather tone them down. It is still "dont do that"
> situation.

I'll add it to my endless to-do pile, but don't hold your breath.

> > > > Sigh.  I _really_ don't have time for this right now.  I wonder if it
> > > > would be possible to just send Patrick some money?
> > >
> > > He's out of time, so money is not likely to help. Sending some money
> > > to Nigel might do the trick ;-).
> >
> > His code isn't the one I've gotten to work yet... :)
>
> 2.4 version should be rather easy to get going...
> 									Pavel

The last time I booted a 2.4 kernel was 2003.  Every time Nigel's code is 
mentioned, 2.4 is also mentioned.  I could also downgrade to 2.2 and debug a 
version written for that, too.  It makes about as much sense to me...

I'll try again when 2.6.6 comes out, as usual...

Rob


