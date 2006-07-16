Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946021AbWGPASc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946021AbWGPASc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 20:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946035AbWGPASc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 20:18:32 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:56534 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1946021AbWGPASb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 20:18:31 -0400
Subject: Re: Linux 2.6.17.6
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, stable@kernel.org
In-Reply-To: <20060715193552.GA5330@kroah.com>
References: <20060715193552.GA5330@kroah.com>
Content-Type: text/plain
Date: Sun, 16 Jul 2006 02:18:03 +0200
Message-Id: <1153009083.12764.18.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> This should fix the reported issue of NetworkManager dying when using
> the 2.6.17.5 kernel release.  All users of the 2.6.17 kernel are
> recommended to upgrade to this kernel, as it fixes a publicly known
> security issue that can provide root access to any local user of the
> machine.

attached is the backported "don't allow chmod()" patch. Please consider
including it into the next stable release. Since the 2.6.17.6 kernel is
no longer vulnerable against CVE-2006-3626, this has no real urgent need
to get out.

Regards

Marcel


