Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265248AbUATB06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 20:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUATBZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 20:25:08 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:50106 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265248AbUATBYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 20:24:47 -0500
Date: Mon, 19 Jan 2004 17:22:45 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: caszonyi@rdslink.ro
Cc: Gerd Knorr <kraxel@bytesex.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Slab coruption and oops with 2.6.1-mm4
Message-ID: <20040120012245.GA1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: caszonyi@rdslink.ro, Gerd Knorr <kraxel@bytesex.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040118220051.3f3d8420.akpm@osdl.org> <20040119121546.GD5498@bytesex.org> <20040119160512.GB8321@bytesex.org> <Pine.LNX.4.53.0401200219170.293@grinch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401200219170.293@grinch.ro>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 02:27:35AM +0200, caszonyi@rdslink.ro wrote:
> When  writing this email (after the oops) i also got this:
> 
> MCE: The hardware reports a non fatal, correctable incident occurred on
> CPU 0.
> Bank 1: 9400000000000151

Ok, run memtest86 on the machine with at least one pass through "all tests"
(that should take several hours depending on memory size, and bandwidth).

Check your power supply, and power source (power from the wall, etc.).

Mike
