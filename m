Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291767AbSBZRQV>; Tue, 26 Feb 2002 12:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292249AbSBZRQL>; Tue, 26 Feb 2002 12:16:11 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:27898
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291767AbSBZRPv>; Tue, 26 Feb 2002 12:15:51 -0500
Date: Tue, 26 Feb 2002 09:16:34 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226171634.GL4393@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB9A3.30408@evision-ventures.com> <20020226164316.GH4393@matchmail.com> <3C7BBDE2.8050207@evision-ventures.com> <20020226170520.GJ4393@matchmail.com> <3C7BC0E5.3060300@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BC0E5.3060300@evision-ventures.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 06:07:49PM +0100, Martin Dalecki wrote:
> >>For the educated user it was always a pain
> >>in the you know where, to constantly run out of quota space due to
> >>file versioning.
> >>
> >
> >Ahh, so we'd need to chown the files to root (or a configurable user and
> >group) to get around the quota issue.
> 
> Welcome to my kill-file. This just shows that you don't even have basic
> background.

Thank you.

Now, if I'm talking out of my ass, can someone sane say so?

It would only call chown/chgrp on the files *inside* the undelete dir, and
user,group,etc would have to be accounted for in another way.  Am I going in
the wrong direction?

Mike
