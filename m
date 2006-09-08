Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750754AbWIHJtx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750754AbWIHJtx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 05:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbWIHJtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 05:49:52 -0400
Received: from anyanka.rfc1149.net ([81.56.47.149]:54223 "EHLO
	mail2.rfc1149.net") by vger.kernel.org with ESMTP id S1750754AbWIHJtw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 05:49:52 -0400
Date: Fri, 8 Sep 2006 11:49:48 +0200
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: add support for w83697hg chip
References: <87fyf5jnkj.fsf@willow.rfc1149.net> <44FEAD7E.6010201@draigBrady.com> <2006-09-06-13-29-46+trackit+sam@rfc1149.net> <44FEB5B6.10008@draigBrady.com> <2006-09-06-14-07-50+trackit+sam@rfc1149.net> <20060906194149.GA2386@infomag.infomag.iguana.be> <2006-09-07-11-57-00+trackit+sam@rfc1149.net> <2006-09-07-18-44-52+trackit+sam@rfc1149.net> <45013506.1090500@draigBrady.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45013506.1090500@draigBrady.com>
User-Agent: Mutt/1.5.11
From: Samuel Tardieu <sam@rfc1149.net>
Organization: RFC 1149 (see http://www.rfc1149.net/)
X-WWW: http://www.rfc1149.net/sam
X-Jabber: <sam@rfc1149.net> (see http://www.jabber.org/)
X-OpenPGP-Fingerprint: 79C0 AE3C CEA8 F17B 0EF1  45A5 F133 2241 1B80 ADE6 (see http://www.gnupg.org/)
Message-Id: <2006-09-08-11-49-49+trackit+sam@rfc1149.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  8/09, Pádraig Brady wrote:

| Personally I don't agree with disabling the watchdog on load.
| If it is already started from the BIOS or GRUB for example,
| there will be a large window of time/logic that is not protected.

Not necessarily: you are free to load the module only when you are ready
to run the controlling program.

