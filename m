Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261434AbVARAEb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261434AbVARAEb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 19:04:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261511AbVARAEb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 19:04:31 -0500
Received: from curlew.cs.man.ac.uk ([130.88.13.7]:21261 "EHLO
	curlew.cs.man.ac.uk") by vger.kernel.org with ESMTP id S261434AbVARAE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 19:04:27 -0500
Message-ID: <41EC75FE.5070505@gentoo.org>
Date: Tue, 18 Jan 2005 02:35:42 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org>	<20050116005930.GA2273@zion.rivenstone.net> <41EAD805.70807@gentoo.org> <1106004708l.24046l.0l@werewolf.able.es>
In-Reply-To: <1106004708l.24046l.0l@werewolf.able.es>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1CqgrC-0004y0-KC*tShCfor9lNg*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> This does not patch against -mm1. -mm1 looks like a mix of plain 2.6.10
> and your code.
> Could you revamp it against -mm1, please ? I looked at it but seems out
> of my understanding...

My patch replaces the one in -mm1.

Just revert the waiting-10s-... patch that is in 2.6.11-rc1-mm1 using patch -p1 -R
Then apply the one I attached to the last mail normally.

I'll also be sending in a cleaner version of the patch shortly.

Daniel
