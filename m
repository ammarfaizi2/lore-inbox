Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbULMPjY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbULMPjY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 10:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbULMPjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 10:39:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51383 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261240AbULMPjV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 10:39:21 -0500
Date: Mon, 13 Dec 2004 10:38:44 -0500
From: Dave Jones <davej@redhat.com>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] enable meye even when CONFIG_HIGHMEM64G=y
Message-ID: <20041213153843.GD31695@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <20041213110753.GB3646@crusoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041213110753.GB3646@crusoe.alcove-fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2004 at 12:07:54PM +0100, Stelian Pop wrote:

 > However, this way of doing it also makes meye unavailable on
 > some kernel configurations. As Arjan said previously, future Fedora
 > kernels will have HIGHMEM64G activated by default. 

Not whilst there are boxes out there that won't boot when PAE
is enabled they won't.

		Dave

