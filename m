Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932257AbWEPWkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932257AbWEPWkL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 18:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932258AbWEPWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 18:40:10 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:41904 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S932257AbWEPWkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 18:40:08 -0400
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, Stephen Street <stephen@streetfiresound.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [PATCH 09/10] spi: Update to PXA2xx SPI Driver
X-Message-Flag: Warning: May contain useful information
References: <1147815518968-git-send-email-greg@kroah.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Fri, 31 Dec 2004 16:10:04 -0800
In-Reply-To: <1147815518968-git-send-email-greg@kroah.com> (Greg KH's message of "Tue, 16 May 2006 14:38:37 -0700")
Message-ID: <adamzvu9fhf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 16 May 2006 22:40:07.0354 (UTC) FILETIME=[AE7381A0:01C67939]
Authentication-Results: sj-dkim-3.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is kind of a weird way to do things: the PXA2xx SPI driver was
just added in patch 2/10.  Why merge a known-buggy driver and then fix
it as part of the same merge?

 - R.
