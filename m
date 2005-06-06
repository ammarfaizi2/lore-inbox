Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbVFFNtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbVFFNtt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 09:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbVFFNtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 09:49:49 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:50436 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261427AbVFFNtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 09:49:41 -0400
Date: Mon, 6 Jun 2005 09:44:26 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Vishal Patil <vishpat@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory problems in schedule()
Message-ID: <20050606134426.GA3756@ccure.user-mode-linux.org>
References: <4745278c050605180115a70b8d@mail.gmail.com> <20050606023145.GB11352@ccure.user-mode-linux.org> <4745278c050606052477561c16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4745278c050606052477561c16@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 06, 2005 at 08:24:39AM -0400, Vishal Patil wrote:
> GNU gdb Red Hat Linux (6.1post-1.20040607.41rh)
> uml-patch-2.4.27-1
> skas mode.

Disable CONFIG_MODE_TT.  gdb seems confused by the exec that tt mode does
early on.

				Jeff
