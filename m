Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312418AbSDJKnN>; Wed, 10 Apr 2002 06:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312427AbSDJKnM>; Wed, 10 Apr 2002 06:43:12 -0400
Received: from [195.157.147.30] ([195.157.147.30]:51718 "HELO
	pookie.dev.sportingbet.com") by vger.kernel.org with SMTP
	id <S312418AbSDJKnL>; Wed, 10 Apr 2002 06:43:11 -0400
Date: Wed, 10 Apr 2002 11:45:21 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Geoffrey Gallaway <geoffeg@sin.sloth.org>, linux-kernel@vger.kernel.org
Subject: Re: Ramdisks and tmpfs problems
Message-ID: <20020410114521.C4493@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	Geoffrey Gallaway <geoffeg@sin.sloth.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020409144639.A14678@sin.sloth.org> <20020410084505.A4493@dev.sportingbet.com> <200204101028.g3AAS2X05866@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 10, 2002 at 01:31:14PM -0200, Denis Vlasenko wrote:
> On 10 April 2002 05:45, Sean Hunter wrote:
> > Wouldn't this be easier?
> >
> > mount -t tmpfs none /dev/shm
> > cp -axf /etc/* !$
> > mount --bind /dev/shm /etc
> 
> /dev is for devices, why do you use it for mounting filesystems?

Normally yes, but the tmpfs provides posix shared memory semantics and thus
/dev/shm is the "normal" place to mount it.  Don't blame me.

Sean
