Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUG0Gld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUG0Gld (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 02:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266292AbUG0Gld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 02:41:33 -0400
Received: from tantale.fifi.org ([216.27.190.146]:20115 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S266335AbUG0GlW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 02:41:22 -0400
To: Aroop MP <aroop@poornam.com>
Cc: Dimitri Sivanich <sivanich@sgi.com>, manfred@colorfullife.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       lse-tech@lists.sourceforge.net
Subject: Re: lsattr: Inappropriate ioctl for device While reading flags!!!
References: <20040723190555.GB16956@sgi.com>
	<200407270729.45116.aroop@poornam.com>
	<20040727020338.GB23967@sgi.com>
	<200407270741.44003.aroop@poornam.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 26 Jul 2004 23:40:57 -0700
In-Reply-To: <200407270741.44003.aroop@poornam.com>
Message-ID: <874qnueyva.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aroop MP <aroop@poornam.com> writes:

> Hi,
> 
> Thanks for your quick reply. When i check lsattr of the file 
> /usr/local/cpanel/3rdparty/etc/php.ini  i got the following error.
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Server[~]# lsattr /usr/local/cpanel/3rdparty/etc/php.ini
> lsattr: Inappropriate ioctl for device While reading flags on 
> /usr/local/cpanel/3rdparty/etc/php.ini
> Server[~]#
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Please get back to me if you need any more  info. regarding this.

Because /usr/local/cpanel/3rdparty/etc/php.ini is not on an ext[23]
filesystem? Remote mounting via NFS, or your favorite network fs does
not count as ext[23].

Phil.
