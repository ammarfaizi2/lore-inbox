Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934258AbWKTQdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934258AbWKTQdO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 11:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934260AbWKTQdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 11:33:14 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:14315 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S934258AbWKTQdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 11:33:13 -0500
Date: Mon, 20 Nov 2006 17:33:11 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: NFSROOT with NFS Version 3
Message-Id: <20061120173311.154e54a6.Christoph.Pleger@uni-dortmund.de>
In-Reply-To: <20061120135716.GA14122@tsunami.ccur.com>
References: <20061117164021.03b2cc24.Christoph.Pleger@uni-dortmund.de>
	<1163780417.5709.34.camel@lade.trondhjem.org>
	<20061120120750.1b1688e8.Christoph.Pleger@uni-dortmund.de>
	<20061120135716.GA14122@tsunami.ccur.com>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.6 (GTK+ 1.2.10; sparc-sun-solaris2.8)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, 20 Nov 2006 08:57:16 -0500
Joe Korty <joe.korty@ccur.com> wrote:

> On Mon, Nov 20, 2006 at 12:07:50PM +0100, Christoph Pleger wrote:
> > Warning: Unable to open an initial console
> 
> This usually means /dev/console doesn't exist.  With many of
> today's distributions, this means you didn't boot with a
> initrd properly set up to run with your newly built kernel.

The device /dev/console exists, but init/main.c tries to open it
read-write. As the nfsroot is mounted read-only, /dev/console cannot be
opened read-write.

Regards
  Christoph Pleger
