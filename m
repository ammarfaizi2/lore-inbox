Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271145AbTGPVUG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 17:20:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271147AbTGPVUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:20:06 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:15364 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271145AbTGPVUA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:20:00 -0400
Date: Wed, 16 Jul 2003 23:34:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030716213451.GA1964@win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716141320.5bd2a8b3.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:13:20PM -0700, Andrew Morton wrote:

> The new dev_t encoding is a bit weird because we of course continue to
> support the old 8:8 encoding.  I think the rule is: "if the top 32-bits are
> zero, it is 8:8, otherwise 32:32".  We can express this nicely with
> "%u:%u".

16-bit only: 8:8, otherwise 32-bit only: 16:16, otherwise 32:32.

Andries

