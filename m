Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSFMDFD>; Wed, 12 Jun 2002 23:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317430AbSFMDFC>; Wed, 12 Jun 2002 23:05:02 -0400
Received: from adsl-63-205-245-1.dsl.snfc21.pacbell.net ([63.205.245.1]:58581
	"EHLO amboise.dolphin") by vger.kernel.org with ESMTP
	id <S317429AbSFMDFB>; Wed, 12 Jun 2002 23:05:01 -0400
Date: Wed, 12 Jun 2002 20:04:35 -0700 (PDT)
From: Francois Gouget <fgouget@free.fr>
X-X-Sender: fgouget@amboise.dolphin
To: Kurt Wall <kwall@kurtwerks.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: vfat patch for shortcut display as symlinks for 2.4.18
In-Reply-To: <20020612222540.23e38e0a.kwall@kurtwerks.com>
Message-ID: <Pine.LNX.4.43.0206121956010.18826-100000@amboise.dolphin>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jun 2002, Kurt Wall wrote:

> Also sprach Alexander Viro:
[...]
> > What the hell do you mean "these files are not Unix files"???  They do
> > have universally understood semantics - persistent named array of
> > characters. That's what Unix files _are_.
>
> That's *precisely* the point I tried to make. .desktop files are just
> plain text files, as far as Unix is concerned. They do not map neatly
> to Windows .lnk files because the kernel's file system layer does
> not handle them specially, as it does symlinks. God and Bill Gates
> alone know how Windows handles .lnk files, but it does seem that Windows
> imputes to them special semantics, rather like a shell script.

Well, you should go talk to Wine hackers one day. More is known about
.lnk files than you think.

The Windows kernel has nothing to do with them. If you want to
dereference .lnk files you have to call a regular user-space library,
more specifically the shell32.dll library. For more information, see the
IShellLink COM interface:
http://msdn.microsoft.com/library/default.asp?url=/library/en-us/shellcc/platform/shell/reference/ifaces/ishelllink/ishelllink.asp


So .lnk files are handled 100% in userspace, just like .desktop files.

[snipping rest of email which is moot]


--
Francois Gouget         fgouget@free.fr        http://fgouget.free.fr/
          tcA thgirypoC muinelliM latigiD eht detaloiv tsuj evah uoY

