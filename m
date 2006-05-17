Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750902AbWEQPDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWEQPDx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 11:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751253AbWEQPDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 11:03:52 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28576 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750902AbWEQPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 11:03:49 -0400
Subject: Re: replacing X Window System !
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux cbon <linuxcbon@yahoo.fr>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
References: <20060517145335.36079.qmail@web26611.mail.ukl.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 16:16:50 +0100
Message-Id: <1147879010.10470.27.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-17 at 16:53 +0200, linux cbon wrote:
> We dont need 2 kernels like today.
> All "dangerous code" should be in kernel.

The kernel is even more privileged than the X server so putting
dangerous code there is counterproductive. Security comes about through
intelligent design decisions, compartmentalisation, isolation of
security critical code segments and the like. If you merely put shit in
a different bucket you still have a bad smell.

Alan
