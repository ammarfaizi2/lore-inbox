Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267919AbTAHV0v>; Wed, 8 Jan 2003 16:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTAHV0v>; Wed, 8 Jan 2003 16:26:51 -0500
Received: from gherkin.frus.com ([192.158.254.49]:31872 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S267919AbTAHV0g>;
	Wed, 8 Jan 2003 16:26:36 -0500
Subject: Re: XFree86 vs. 2.5.54 - reboot
In-Reply-To: <3E1C880A.87A93CFA@digeo.com> "from Andrew Morton at Jan 8, 2003
 12:20:26 pm"
To: Andrew Morton <akpm@digeo.com>
Date: Wed, 8 Jan 2003 15:35:17 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030108213517.7F32F4EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Bob_Tracy(0000)" wrote:
> > AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
> > a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
> > reboot when I type "startx".
> 
> I saw exactly the same.  In my case it appears to be due to miscompilation
> of a particular sysenter patch which went into 2.5.53.  If you're using
> gcc-2.91.66 (aka `kgcc') then try 2.95.x instead.

I'm running gcc-2.95.3 here.  Is that a "sufficiently correct" version
to avoid the miscompilation problem?

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
