Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265278AbUAESzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 13:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265295AbUAESzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 13:55:33 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:30016 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP id S265278AbUAESzT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 13:55:19 -0500
Date: Mon, 5 Jan 2004 20:55:06 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: 2.6.0 under vmware ?
Message-ID: <20040105185506.GF11115091@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Petr Vandrovec <vandrove@vc.cvut.cz>
References: <1073297203.12550.30.camel@bip.parateam.prv> <20040105142032.GE11115091@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040105142032.GE11115091@niksula.cs.hut.fi>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 05, 2004 at 04:20:32PM +0200, you [Ville Herva] wrote:
>
> There is one regression, though: 2.2.x and 2.4.x can see /dev/fd0 and
> /dev/fd1 under vmware. 2.6.1rc1 only find /dev/fd0. Does anyone else see
> this?

Turns out the second floppy drive was disabled from the bios.

Oddly, 2.2 and 2.4 don't care.

If I turn the second drive on from the bios, 2.6 finds it, too.


-- v --

v@iki.fi
