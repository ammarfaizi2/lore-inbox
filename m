Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262328AbUBJXSE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 18:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbUBJXSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 18:18:04 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262328AbUBJXSC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 18:18:02 -0500
Date: Tue, 10 Feb 2004 23:17:58 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org,
       Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040210231756.GI21151@parcelfarce.linux.theplanet.co.uk>
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de> <20040210043212.GF18674@srv-lnx2600.matchmail.com> <20040210230452.GA15892@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210230452.GA15892@pegasys.ws>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:04:52PM -0800, jw schultz wrote:
> I expect UTF-8 to have no multi-byte sequences containing NUL
> but it might be awkward if a multi-byte sequence contained
> 0x2F (/).  I would hope that the committees chose to avoid
> using symbol and punctuation byte-codes for alphanumeric
> sequences.

UTF-8 single-byte sequences are in range 0--127 with obvious mapping to
ASCII.  All bytes in UTF-8 multi-byte sequences are in range 128--255.
