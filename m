Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291245AbSBZQr6>; Tue, 26 Feb 2002 11:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291193AbSBZQru>; Tue, 26 Feb 2002 11:47:50 -0500
Received: from zeus.kernel.org ([204.152.189.113]:51623 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S291269AbSBZQrn>;
	Tue, 26 Feb 2002 11:47:43 -0500
Date: Tue, 26 Feb 2002 08:43:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020226164316.GH4393@matchmail.com>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
In-Reply-To: <fa.n4lfl6v.h4chor@ifi.uio.no> <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <20020225172048.GV20060@matchmail.com> <02022518330103.01161@grumpersII> <a5f7s4$2o1$1@cesium.transmeta.com> <20020226160544.GD4393@matchmail.com> <3C7BB9A3.30408@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C7BB9A3.30408@evision-ventures.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2002 at 05:36:51PM +0100, Martin Dalecki wrote:
> >True, and it could to tricks like listing space used for undelete as "free"
> >in addition to dynamic garbage collection.
> >
> >Though, with a daemon checking the dirs often, or using Daniel's idea of a
> >socket between unlink() in glibc and an undelete daemon could work quite
> >similairly.
> >
> >Also, there wouldn't be any interaction with filesystem internals, and
> >userspace would probably work better with non-posix type filesystems (vfat,
> >hfs, etc) too.
> >
> >IOW, there seems to be little gain to having an kernelspace solution.
> >
> 
> IMNSHO everyone thinking about undeletion in Linux should be
> sentenced to 1 year of VMS usage and asked then again if he
> still think's that it's a good idea...

Can you describe the pitfalls that VMS went through so we can aviod the
problems?

I haven't had the chance to use VMS, and don't have any hardware to try it
out on.  Also, just because one implementation was bad (even long ago, and
unix was considered bad then too... ;) does it mean the entire idea is bad.

Mike
