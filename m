Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932890AbWF2LTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932890AbWF2LTG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 07:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932888AbWF2LTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 07:19:05 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:55176 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932890AbWF2LS7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 07:18:59 -0400
Subject: Re: [PATCH] ia64: change usermode HZ to 250
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jes Sorensen <jes@sgi.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, John Daiker <jdaiker@osdl.org>,
       John Hawkes <hawkes@sgi.com>, Arjan van de Ven <arjan@infradead.org>,
       Tony Luck <tony.luck@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jack Steiner <steiner@sgi.com>, Dan Higgins <djh@sgi.com>,
       Jeremy Higdon <jeremy@sgi.com>
In-Reply-To: <44A3AFFB.2000203@sgi.com>
References: <617E1C2C70743745A92448908E030B2A27FC5F@scsmsx411.amr.corp.intel.com>
	 <yq04py4i9p7.fsf@jaguar.mkp.net>
	 <1151578928.23785.0.camel@localhost.localdomain> <44A3AFFB.2000203@sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 29 Jun 2006 12:34:59 +0100
Message-Id: <1151580899.23785.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Iau, 2006-06-29 am 12:48 +0200, ysgrifennodd Jes Sorensen:
> > No need, all current mainstream architectures expose a constant user HZ.
> 
> But you are still going to have the issue where someone installs their
> own kernel and apps will break because of this? Getting the distros to
> stop publishing a constant HZ is probably the right solution, but more
> difficult :(

Read what I said - "all current mainstream architectures expose a
constant user HZ".

The HZ used by the kernel is independant of the HZ seen for /proc etc



