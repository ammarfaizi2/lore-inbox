Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265073AbUFMOYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbUFMOYX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 10:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbUFMOYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 10:24:23 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:51716 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S265073AbUFMOYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 10:24:22 -0400
Date: Sun, 13 Jun 2004 16:24:40 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] 2.6.6 tty_io.c hangup locking
Message-ID: <20040613142440.GA31015@quadpro.stupendous.org>
Mail-Followup-To: Paul Fulghum <paulkf@microgate.com>,
	linux-kernel@vger.kernel.org
References: <20040527174509.GA1654@quadpro.stupendous.org> <1085769769.2106.23.camel@deimos.microgate.com> <20040613090543.GA29699@quadpro.stupendous.org> <1087133357.16761.11.camel@at2.pipehead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1087133357.16761.11.camel@at2.pipehead.org>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 08:29:17AM -0500, Paul Fulghum wrote:

> Could I persuade you to also try this patch for ppp_synctty.c?

The patch doesn't apply: it seems to contain spaces where there are
tabs in the original file, and some lines seem to be cut off early...

> If I remember correctly, you were using this module for PPPoE.

PPTP actually, but I do use the "sync" option of pppd.

-- 
Jurjen Oskam

"Avoid putting a paging file on a fault-tolerant drive, such as a mirrored
volume or a RAID-5 volume. Paging files do not need fault-tolerance."-MS Q308417
