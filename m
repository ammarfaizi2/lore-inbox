Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbUKQWyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUKQWyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 17:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbUKQWw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 17:52:58 -0500
Received: from fw.osdl.org ([65.172.181.6]:59780 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262591AbUKQWwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 17:52:36 -0500
Date: Wed, 17 Nov 2004 14:56:44 -0800
From: Andrew Morton <akpm@osdl.org>
To: "John W. Linville" <linville@tuxdriver.com>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, alan@redhat.com
Subject: Re: [patch 2.6.10-rc2] oss: AC97 quirk facility
Message-Id: <20041117145644.005e54ff.akpm@osdl.org>
In-Reply-To: <20041117163016.A5351@tuxdriver.com>
References: <20041117163016.A5351@tuxdriver.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John W. Linville" <linville@tuxdriver.com> wrote:
>
> Add a quirk facility for AC97 in OSS, and add a quirk list for the
> i810_audio driver.
> 
> Signed-off-by: John W. Linville <linville@tuxdriver.com>
> ---
> This allows automatically "correct" behaviour for sound hardware w/
> known oddities.  For example, many cards have the headphone and
> line-out outputs swapped or headphone outputs only.
> 
> The code is stolen shamelessly from ALSA, FWIW...

Dumb question: why not just use the ALSA driver?
