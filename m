Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbTJHTnb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 15:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbTJHTnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 15:43:31 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:37258 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261757AbTJHTna
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 15:43:30 -0400
Date: Wed, 8 Oct 2003 20:43:17 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: changes to microcode update driver.
Message-ID: <20031008194317.GA15832@mail.shareable.org>
References: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 1. Remove ->read() method for /dev/cpu/microcode device node and do not
> hold a copy of applied microcode chunks in kernel memory. In the days when
> we had a regular devfs file with a non-zero size this had at least some
> potential use but now this feature is almost useless and removing it would
> allow a lot of code cleanup and simplification.

It would be nice to record the MD5 or SHA checksum of the loaded
microcode, so it's possible to check which one was loaded.

-- Jamie
