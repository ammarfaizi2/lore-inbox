Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbVJLXcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbVJLXcH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 19:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932100AbVJLXcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 19:32:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55216 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932318AbVJLXcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 19:32:06 -0400
Date: Wed, 12 Oct 2005 16:31:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: "Gabriel A. Devenyi" <ace@staticwave.ca>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] nfsv4 in linux 2.6.13 (-ck7)
Message-ID: <20051012233159.GJ5856@shell0.pdx.osdl.net>
References: <200510121903.04485.ace@staticwave.ca> <20051012232418.GQ7991@shell0.pdx.osdl.net> <200510121927.22296.ace@staticwave.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510121927.22296.ace@staticwave.ca>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gabriel A. Devenyi (ace@staticwave.ca) wrote:
> Of course, my apologies, however, this is a fs error, is it even
> conceivable that something such as the nvidia kernel driver could
> affect this?

In this case it's not very likely since others are seeing same problem
under load.  However, a binary module can corrupt any kernel memory.
So as a general rule all bets are off with a binary module loaded.

thanks,
-chris
