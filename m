Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUJOQHD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUJOQHD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUJOQHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:07:02 -0400
Received: from dspnet.fr.eu.org ([62.73.5.179]:60944 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S268127AbUJOQFe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:05:34 -0400
Date: Fri, 15 Oct 2004 18:05:32 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Fw: signed kernel modules?
Message-ID: <20041015160532.GA11104@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	David Woodhouse <dwmw2@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200410151140_MC3-1-8C5D-1649@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410151140_MC3-1-8C5D-1649@compuserve.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 11:37:57AM -0400, Chuck Ebbert wrote:
>   OK, so why no integrity-checking code for the kernel itself?  Surely it too
> could be accidentally corrupted...

The kernel is CRC32-ed.  Maybe it's part of the bzimage handling
though.

  OG.
