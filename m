Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293612AbSBZWEd>; Tue, 26 Feb 2002 17:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293611AbSBZWEX>; Tue, 26 Feb 2002 17:04:23 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:6398
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293609AbSBZWEQ>; Tue, 26 Feb 2002 17:04:16 -0500
Date: Tue, 26 Feb 2002 14:04:47 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Rik van Riel <riel@conectiva.com.br>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226220447.GS4393@matchmail.com>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020226171634.GL4393@matchmail.com> <Pine.LNX.4.44L.0202261419240.1413-100000@duckman.distro.conectiva> <20020226173822.GN4393@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020226173822.GN4393@matchmail.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 09:38:22AM -0800, Mike Fedyk wrote:
> On Tue, Feb 26, 2002 at 02:22:31PM -0300, Rik van Riel wrote:
> > Your idea should work on deletion, when the inode were
> > about to be destroyed, but ...
> > 
> > > It would only call chown/chgrp on the files *inside* the undelete dir,
> > > and user,group,etc would have to be accounted for in another way.  Am I
> > > going in the wrong direction?
> > 
> > ... of course, there still is the problem of hard links.
> > 
> 
> I had considered hard links.  Take a look at my another message from me in
> this thread and see Daniel's response to it.
>

Correction, that was Andreas Dilger that replied offline, and has been
posted by me with his permission.

And now the idea of chgrp/chown is out of the question...

Mike
