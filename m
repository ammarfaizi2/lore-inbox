Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbTINRRn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 13:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261210AbTINRRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 13:17:43 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:60138 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261206AbTINRRm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 13:17:42 -0400
Date: Sun, 14 Sep 2003 19:17:41 +0200
From: bert hubert <ahu@ds9a.nl>
To: Mo McKinlay <lkml@ekto.ekol.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: logging when SIGSEGV is processed?
Message-ID: <20030914171741.GA18627@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Mo McKinlay <lkml@ekto.ekol.co.uk>, linux-kernel@vger.kernel.org
References: <20030914111408.GA14514@strawberry.blancmange.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914111408.GA14514@strawberry.blancmange.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 12:14:08PM +0100, Mo McKinlay wrote:

> Admittedly, it might need some shoehorning into some existing setups (i.e.,
> where the daemon you wish to watch isn't started directly, but by something
> else), but it wouldn't be too tricky, I'd've thought.

init receives that stuff if a process has no other parent, I think, so that
might be a great place.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
