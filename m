Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbVAYHVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbVAYHVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 02:21:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261848AbVAYHVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 02:21:31 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:10413 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261843AbVAYHV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 02:21:27 -0500
Date: Mon, 24 Jan 2005 23:21:20 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Enforce USB interface claims
Message-ID: <20050125072120.GB14960@taniwha.stupidest.org>
References: <20050123111258.GA29513@taniwha.stupidest.org> <20050125060555.GC2061@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050125060555.GC2061@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:05:55PM -0800, Greg KH wrote:

> Um, why?  I think this is there to help with "broken" userspace code
> that was written before we enforced the rules of "you must claim an
> interface before using it.  As such, I don't think we can apply this
> patch.

right now such broken userspace spams kern.log, etc.  also it means
you can run two or more instances of something that fail to claim the
endpoint and then fight over packets from it
