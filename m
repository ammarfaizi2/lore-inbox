Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265209AbUAJPtm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 10:49:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265217AbUAJPtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 10:49:42 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:24710 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S265209AbUAJPtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 10:49:41 -0500
Date: Sat, 10 Jan 2004 10:49:02 -0500
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-mm2] e100 driver hangs after period of moderate receive load
Message-ID: <20040110154902.GA23063@gnu.org>
References: <20031231110209.GA9858@gnu.org> <3FF2BCDE.5010302@pobox.com> <20031231122155.GA13323@gnu.org> <3FF2C266.8010104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FF2C266.8010104@pobox.com>
User-Agent: Mutt/1.3.28i
From: Lennert Buytenhek <buytenh@gnu.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 31, 2003 at 07:34:46AM -0500, Jeff Garzik wrote:

> Well, the two are vastly different, since -mm2 includes a complete 
> rewrite of e100.
> 
> Does disabling NAPI in -mm2 change anything?

Disabling NAPI makes the slab corruption harder to trigger, but
it still occurs.


--L
