Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272976AbTHRQvO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 12:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272691AbTHRQvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 12:51:14 -0400
Received: from [63.247.75.124] ([63.247.75.124]:43409 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S272976AbTHRQvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 12:51:10 -0400
Date: Mon, 18 Aug 2003 12:51:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ALPHA] Update for "name" out of struct device.
Message-ID: <20030818165109.GG24693@gtf.org>
References: <200308181611.h7IGBEcW024487@hera.kernel.org> <20030818164512.GF24693@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030818164512.GF24693@gtf.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 18, 2003 at 12:45:12PM -0400, Jeff Garzik wrote:
> What do you think about the following patch?  It follows the style of
> other PCI core messages, and prints out the same information as before.

...except for the pretty name, of course.

But IMO we need to stop drivers and core from printing out pretty-name
at all, which is another reason for my patch.  Having name information
like this in the kernel, overall, is a waste, IMO.  _Especially_ when
that information is conditional.  We should be consistent with what we
print out, to reduce user confusion.

	Jeff



