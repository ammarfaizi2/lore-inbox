Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVCFSzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVCFSzt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 13:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVCFSzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 13:55:49 -0500
Received: from mail.gondor.com ([212.117.64.182]:6931 "EHLO moria.gondor.com")
	by vger.kernel.org with ESMTP id S261467AbVCFSzo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 13:55:44 -0500
Date: Sun, 6 Mar 2005 19:55:39 +0100
From: Jan Niehusmann <jan@gondor.com>
To: linux-kernel@vger.kernel.org
Cc: len.brown@intel.com
Subject: Re: bouncing keys and skipping sound with 2.6.11
Message-ID: <20050306185539.GA2149@gondor.com>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> <20050228184414.GA31929@gondor.com> <20050302200632.GA24529@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050302200632.GA24529@gondor.com>
X-Request-PGP: http://gondor.com/key.asc
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 09:06:32PM +0100, Jan Niehusmann wrote:
> the problem with bouncing keys I reported with 2.6.11-rc5 is still
> present in 2.6.11. Additionally, I noticed that audio has short outages

By trying different kernel versions, I traced down the problem to the
changes introduced between linux-2.6.11-rc2-bk9 and
linux-2.6.11-rc2-bk10, and, more specifically, to the ACPI changes
within that patch. (Therefore the Cc: to Len Brown, who wrote or
submitted most of these changes, as far as I can tell from the
changelog)

Len, do you have any idea which of the ACPI changes could have caused
the described key bouncing problems on my ASUS M2400N laptop, or how I
could debug this?

Yours,
Jan

