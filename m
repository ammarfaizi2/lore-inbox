Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262395AbVF2FEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262395AbVF2FEL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 01:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262397AbVF2FEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 01:04:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55454 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262395AbVF2FEG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 01:04:06 -0400
Date: Tue, 28 Jun 2005 22:03:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Richards <mrmikerich@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap partition vs swap file
Message-Id: <20050628220334.66da4656.akpm@osdl.org>
In-Reply-To: <516d7fa80506281757188b2fda@mail.gmail.com>
References: <516d7fa80506281757188b2fda@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Richards <mrmikerich@gmail.com> wrote:
>
> Given this situation, is there any significant performance or
>  stability advantage to using a swap partition instead of a swap file?

In 2.6 they have the same reliability and they will have the same
performance unless the swapfile is badly fragmented.
