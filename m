Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265810AbUADXrV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 18:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265812AbUADXrV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 18:47:21 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:6574 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265810AbUADXrT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 18:47:19 -0500
Date: Sun, 4 Jan 2004 15:47:03 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: szonyi calin <caszonyi@yahoo.com>, azarah@nosferatu.za.org,
       Con Kolivas <kernel@kolivas.org>, Soeren Sonnenburg <kernel@nn7.de>,
       Mark Hahn <hahn@physics.mcmaster.ca>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       gillb4@telusplanet.net
Subject: Re: xterm scrolling speed - scheduling weirdness in 2.6 ?!
Message-ID: <20040104234703.GY1882@matchmail.com>
Mail-Followup-To: Willy Tarreau <willy@w.ods.org>,
	szonyi calin <caszonyi@yahoo.com>, azarah@nosferatu.za.org,
	Con Kolivas <kernel@kolivas.org>, Soeren Sonnenburg <kernel@nn7.de>,
	Mark Hahn <hahn@physics.mcmaster.ca>,
	Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
	gillb4@telusplanet.net
References: <1073227359.6075.284.camel@nosferatu.lan> <20040104225827.39142.qmail@web40613.mail.yahoo.com> <20040104233312.GA649@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104233312.GA649@alpha.home.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 12:33:12AM +0100, Willy Tarreau wrote:
> at a time. I have yet to understand why 'ls|cat' behaves
> differently, but fortunately it works and it has already saved
> me some useful time.

cat probably does some buffering for you, and sends the output to xterm in
larger blocks.
