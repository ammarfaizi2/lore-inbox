Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751000AbVJ3OW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbVJ3OW3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 09:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbVJ3OW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 09:22:29 -0500
Received: from cassarossa.samfundet.no ([129.241.93.19]:25003 "EHLO
	cassarossa.samfundet.no") by vger.kernel.org with ESMTP
	id S1750995AbVJ3OW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 09:22:28 -0500
Date: Sun, 30 Oct 2005 15:22:23 +0100
From: "Steinar H. Gunderson" <sgunderson@bigfoot.com>
To: bert hubert <bert.hubert@netherlabs.nl>, linux-kernel@vger.kernel.org
Subject: Re: BIND hangs with 2.6.14
Message-ID: <20051030142223.GA12146@uio.no>
References: <20051030023557.GA7798@uio.no> <20051030101148.GA18854@outpost.ds9a.nl> <20051030104527.GB32446@uio.no> <20051030110021.GA19680@outpost.ds9a.nl> <20051030113651.GA1780@uio.no> <20051030114537.GA20564@outpost.ds9a.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20051030114537.GA20564@outpost.ds9a.nl>
X-Operating-System: Linux 2.6.14-rc5 on a x86_64
X-Message-Flag: Outlook? --> http://www.mozilla.org/products/thunderbird/
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 12:45:38PM +0100, bert hubert wrote:
> Switching to/from NPTL might very well change the address btw.

FWIW, I tried without NPTL, and it gave the same problem after an hour or so.

I've compiled some extra debugging code (printing the msg_hdr structure if
recvmsg() should fail with a hard error) into named, so I'm waiting for the
problem to manifest itself again.

/* Steinar */
-- 
Homepage: http://www.sesse.net/
