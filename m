Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261555AbTI3PQe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 11:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261559AbTI3PQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 11:16:33 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:23310 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S261555AbTI3PQZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 11:16:25 -0400
Date: Tue, 30 Sep 2003 17:07:49 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Ivo van Doorn" <ivd@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] setkeycodes with 2.6.0-test5 / -test6
Message-ID: <20030930150749.GB1297@win.tue.nl>
References: <20030930095308.19043.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930095308.19043.qmail@linuxmail.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 30, 2003 at 10:53:08AM +0100, Ivo van Doorn wrote:

> I've been working on a kernelpatch for the 2.6 test kernel named the Funkey patch.
...
> setkeycodes e05b 89
> did not help. keycode for this key remained 125.

Yes, the KDSETKEYCODE ioctl is broken today.
See some other letter that I wrote a few minutes ago.

Will be fixed.

