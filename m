Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261462AbULNJqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261462AbULNJqA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:46:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbULNJqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:46:00 -0500
Received: from [213.146.154.40] ([213.146.154.40]:48523 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261462AbULNJp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:45:56 -0500
Date: Tue, 14 Dec 2004 09:45:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Adrian Bunk <bunk@stusta.de>, Max Krasnyansky <maxk@qualcomm.com>,
       bluez-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Network Development Mailing List <netdev@oss.sgi.com>
Subject: Re: [2.6 patch] net/bluetooth/: misc possible cleanups
Message-ID: <20041214094543.GA963@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcel Holtmann <marcel@holtmann.org>, Adrian Bunk <bunk@stusta.de>,
	Max Krasnyansky <maxk@qualcomm.com>,
	bluez-devel@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Network Development Mailing List <netdev@oss.sgi.com>
References: <20041214041352.GZ23151@stusta.de> <1103009649.2143.65.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103009649.2143.65.camel@pegasus>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2004 at 08:34:08AM +0100, Marcel Holtmann wrote:
> these functions must stay. They have users outside the mainline kernel
> that are not merged back yet. Otherwise they won't be exported ;)

But we traditionally don't keep APIs only for the sake of external modules.
Exceptions are made if you have short- to mid-term plans to merge them.

