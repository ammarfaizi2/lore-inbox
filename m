Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUIJQgE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUIJQgE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 12:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUIJQbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 12:31:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38051 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267558AbUIJQaB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 12:30:01 -0400
Date: Fri, 10 Sep 2004 17:30:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Cherry <cherry@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 6 New compile/sparse warnings (overnight build)
Message-ID: <20040910163000.GP23987@parcelfarce.linux.theplanet.co.uk>
References: <1094832133.2364.0.camel@cherrybomb.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094832133.2364.0.camel@cherrybomb.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 09:05:57AM -0700, John Cherry wrote:
> New warnings:
> -------------
> drivers/net/tulip/dmfe.c

See reply re cc(1) warnings in the same place.
 
> fs/reiserfs/do_balan.c:463:8: warning: too long token expansion

Heh.  2400-odd bytes coming from a single macro...
