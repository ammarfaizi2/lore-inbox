Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUADRa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 12:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265801AbUADRa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 12:30:29 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:37579 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265796AbUADRa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 12:30:27 -0500
Date: Sun, 4 Jan 2004 09:30:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Cristiano De Michele <demichel@na.infn.it>
Cc: Willy Tarreau <willy@w.ods.org>,
       linux kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23 oops
Message-ID: <20040104173016.GS1882@matchmail.com>
Mail-Followup-To: Cristiano De Michele <demichel@na.infn.it>,
	Willy Tarreau <willy@w.ods.org>,
	linux kernel ML <linux-kernel@vger.kernel.org>
References: <1073223226.1695.10.camel@cripat.acasa-tr.it> <20040104143555.GF3728@alpha.home.local> <1073236750.2327.2.camel@cripat.acasa-tr.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073236750.2327.2.camel@cripat.acasa-tr.it>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 06:19:11PM +0100, Cristiano De Michele wrote:
> ok you were right it was the RAM, disabling the bank interleave and
> increasing the CAS latency in the BIOS settings it seems
> that now my system is pretty stable (using memtest86)

Good.

Did you try changing those two settings seperately?  You may be able to have
the interleave with the higher cas latency, but you'll have to test with
memtest86 after each change...
