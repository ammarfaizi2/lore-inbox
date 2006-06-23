Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752107AbWFWVq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbWFWVq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 17:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbWFWVq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 17:46:27 -0400
Received: from [198.99.130.12] ([198.99.130.12]:57749 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1752100AbWFWVq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 17:46:26 -0400
Date: Fri, 23 Jun 2006 17:46:23 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Theodore Tso <tytso@mit.edu>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060623214623.GA7319@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060623024222.GA8316@ccure.user-mode-linux.org> <20060623210714.GA16661@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060623210714.GA16661@thunk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2006 at 05:07:14PM -0400, Theodore Tso wrote:
> Well, because my host kernel is running a completely stock 2.6.17
> kernel and so I don't have the SKAS patch applied.  If the goal is to
> abandon tt mode, it would be really nice if the SKAS patch gets
> integrated into mainline first....

UML has a form of skas which runs on stock hosts.  defconfig will give
you a CONFIG_MODE_SKAS, !CONFIG_MODE_TT UML which will run on an
unmodified host.

				Jeff
