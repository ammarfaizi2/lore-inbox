Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265255AbTAJP1t>; Fri, 10 Jan 2003 10:27:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTAJP1s>; Fri, 10 Jan 2003 10:27:48 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51585 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265255AbTAJP1q>;
	Fri, 10 Jan 2003 10:27:46 -0500
Date: Fri, 10 Jan 2003 15:34:21 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Bob_Tracy(0000)" <rct@gherkin.frus.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: XFree86 vs. 2.5.54 - reboot
Message-ID: <20030110153421.GB21190@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"Bob_Tracy(0000)" <rct@gherkin.frus.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <3E1C9D9A.FD5CA1F6@digeo.com> <20030110152659.3F04E4EE7@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030110152659.3F04E4EE7@gherkin.frus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2003 at 09:26:59AM -0600, Bob_Tracy(0000) wrote:

 > > > > > AMD K6-III 450 running a 2.4.19 kernel with vesafb, XFree86 4.1.0, and
 > > > > > a USB mouse works fine.  Same setup with a 2.5.54 kernel does a cold
 > > > > > reboot when I type "startx".
 > > Yup.  It must be something else then.  Perhaps you should try disabling
 > > various DRM/AGP type things in config, see if that helps.
 > 
 > I wrote:
 > > 2.5.55 appears to work fine with CONFIG_AGP and CONFIG_DRM undefined.
 > > I'll retry with CONFIG_AGP_MODULE next...
 > 
 > CONFIG_AGP_MODULE enabled works fine with CONFIG_AGP_VIA_MODULE.  I'll try
 > turning everything back on (AGP 3.0 compliance, DRM) and see what happens.

Can you send me lspci output, and agp related msgs from dmesg.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
