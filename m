Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261426AbVB1MXH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVB1MXH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 07:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261459AbVB1MXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 07:23:07 -0500
Received: from zamok.crans.org ([138.231.136.6]:11926 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S261426AbVB1MXE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 07:23:04 -0500
From: Mathieu Segaud <Mathieu.Segaud@crans.org>
To: Iwan Sanders <iwan.sanders@tuxproject.info>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bigmem in Linux 2.6.8
References: <421DE9A9.4090902@wasp.net.au> <421F4629.5080309@wasp.net.au>
	<16930.45319.682534.351648@cse.unsw.edu.au>
	<1109583765.4222e795e12d4@www.proserv.ath.cx>
Date: Mon, 28 Feb 2005 13:23:02 +0100
In-Reply-To: <1109583765.4222e795e12d4@www.proserv.ath.cx> (Iwan Sanders's
	message of "Mon, 28 Feb 2005 10:42:45 +0100")
Message-ID: <87vf8c7u1l.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Iwan Sanders <iwan.sanders@tuxproject.info> disait dernièrement que :

> Hi,
>
> I've got a quick question about the amount of memory used by Linux.
> I compiled a 2.6.8 kernel on a machine with 2GB internal memory but
> it seems to use only 882MB. Did I miss an option in the config file?

you did, CONFIG_HIGHMEM must be set to y
it is in "Processor type and features" section

-- 
"The 'C' language can order structure members anyway it wants."

	- Richard B. Johnson
