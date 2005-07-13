Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262576AbVGMTdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262576AbVGMTdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262455AbVGMTbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:31:40 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:2052 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S262617AbVGMTKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:10:45 -0400
Date: Wed, 13 Jul 2005 15:09:27 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Greg KH <gregkh@suse.de>
Cc: kjhall@us.ibm.com, bjorn.helgaas@hp.com, tpmdd-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [06/11] tpm breaks 8139cp
Message-ID: <20050713190924.GA19577@tuxdriver.com>
Mail-Followup-To: Greg KH <gregkh@suse.de>, kjhall@us.ibm.com,
	bjorn.helgaas@hp.com, tpmdd-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, stable@kernel.org,
	Justin Forbes <jmforbes@linuxtx.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Theodore Ts'o <tytso@mit.edu>,
	"Randy.Dunlap" <rdunlap@xenotime.net>,
	Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
	akpm@osdl.org, alan@lxorguk.ukuu.org.uk
References: <20050713184130.GA9330@kroah.com> <20050713184341.GH9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184341.GH9330@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 11:43:41AM -0700, Greg KH wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> 
> ------------------
> 
> A problem was reported that the tpm driver was interfereing with
> networking on the 8139 chipset.  The tpm driver was using a hard coded

ACK...this looks very similar to a patch I got from Kylene for fixing
this same issue when it showed-up in FC4.

John
-- 
John W. Linville
linville@tuxdriver.com
