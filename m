Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267907AbTAHVnw>; Wed, 8 Jan 2003 16:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267906AbTAHVnw>; Wed, 8 Jan 2003 16:43:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:24507 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267907AbTAHVnv>;
	Wed, 8 Jan 2003 16:43:51 -0500
Message-ID: <3E1C9D9A.FD5CA1F6@digeo.com>
Date: Wed, 08 Jan 2003 13:52:26 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.51 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bob_Tracy(0000)" <rct@gherkin.frus.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: XFree86 vs. 2.5.54 - reboot
References: <3E1C880A.87A93CFA@digeo.com> "from Andrew Morton at Jan 8, 2003
	 12:20:26 pm" <20030108213517.7F32F4EE7@gherkin.frus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Jan 2003 21:52:26.0719 (UTC) FILETIME=[3BC33EF0:01C2B760]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bob_Tracy(0000)" wrote:
> 
> Andrew Morton wrote:
> > "Bob_Tracy(0000)" wrote:
> > > AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
> > > a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
> > > reboot when I type "startx".
> >
> > I saw exactly the same.  In my case it appears to be due to miscompilation
> > of a particular sysenter patch which went into 2.5.53.  If you're using
> > gcc-2.91.66 (aka `kgcc') then try 2.95.x instead.
> 
> I'm running gcc-2.95.3 here.  Is that a "sufficiently correct" version
> to avoid the miscompilation problem?
> 

Yup.  It must be something else then.  Perhaps you should try disabling
various DRM/AGP type things in config, see if that helps.  If not, it would
help if you could identify the kernel version at which the failure started
to occur.
