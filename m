Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265168AbTAJPSP>; Fri, 10 Jan 2003 10:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265169AbTAJPSP>; Fri, 10 Jan 2003 10:18:15 -0500
Received: from gherkin.frus.com ([192.158.254.49]:896 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S265168AbTAJPSP>;
	Fri, 10 Jan 2003 10:18:15 -0500
Subject: Re: XFree86 vs. 2.5.54 - reboot
In-Reply-To: <3E1C9D9A.FD5CA1F6@digeo.com> "from Andrew Morton at Jan 8, 2003
 01:52:26 pm"
To: Andrew Morton <akpm@digeo.com>
Date: Fri, 10 Jan 2003 09:26:59 -0600 (CST)
Cc: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030110152659.3F04E4EE7@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > > "Bob_Tracy(0000)" wrote:
> > > > AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
> > > > a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
> > > > reboot when I type "startx".
> 
> Yup.  It must be something else then.  Perhaps you should try disabling
> various DRM/AGP type things in config, see if that helps.

I wrote:
> 2.5.55 appears to work fine with CONFIG_AGP and CONFIG_DRM undefined.
> I'll retry with CONFIG_AGP_MODULE next...

CONFIG_AGP_MODULE enabled works fine with CONFIG_AGP_VIA_MODULE.  I'll try
turning everything back on (AGP 3.0 compliance, DRM) and see what happens.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
