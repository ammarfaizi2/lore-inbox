Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311564AbSC2Srk>; Fri, 29 Mar 2002 13:47:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311264AbSC2Sra>; Fri, 29 Mar 2002 13:47:30 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:54007
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311024AbSC2SrW>; Fri, 29 Mar 2002 13:47:22 -0500
Date: Fri, 29 Mar 2002 10:49:06 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cus.cam.ac.uk>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
Message-ID: <20020329184906.GH8627@matchmail.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Padraig Brady <padraig@antefacto.com>,
	Anton Altaparmakov <aia21@cus.cam.ac.uk>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-ntfs-dev@lists.sourceforge.net
In-Reply-To: <3CA4703C.8000900@antefacto.com> <Pine.LNX.3.95.1020329085743.147A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 29, 2002 at 09:13:38AM -0500, Richard B. Johnson wrote:
> If the files are NOT set to 'executable' as read by Linux, then samba
> will not work. For the files to be visible to WIN/Clients, they
> must have all bits set. This 'feature' can be used to make DOS/Win
> files temporarily off-limits to WIN/Clients (like during a backup).
>

Since when?

None of the of the data files on my samba server are marked executable, and
all are readable.

You probably have "map archive = yes" in mind, but that will *not* deny access if
the executable bit is set or not...

This is looking at the manual for smb.conf in 2.2.3a.

Mike
