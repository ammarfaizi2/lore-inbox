Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262784AbUCJTY2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 14:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbUCJTY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 14:24:28 -0500
Received: from holomorphy.com ([207.189.100.168]:41229 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262784AbUCJTYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 14:24:25 -0500
Date: Wed, 10 Mar 2004 11:24:15 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Miek Gieben <miekg@atoom.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pts/X counts on
Message-ID: <20040310192415.GL655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Miek Gieben <miekg@atoom.net>, linux-kernel@vger.kernel.org
References: <20040310190902.GA2226@atoom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310190902.GA2226@atoom.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 08:09:02PM +0100, Miek Gieben wrote:
> It just counts on.... 
> I'm using devfs on 2.6.4-rc3, I first noticed this in 2.6.3.
> (all 2.6.4-rcX have it),
> Does anybody know why this is happening?

This change in behavior was intentional. It should not affect your
applications. The change was part of a patch that made pty's
completely dynamic.


-- wli
