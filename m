Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750811AbVLYKMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbVLYKMp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 05:12:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbVLYKMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 05:12:45 -0500
Received: from levante.wiggy.net ([82.94.255.194]:30866 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S1750811AbVLYKMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 05:12:44 -0500
Date: Sun, 25 Dec 2005 11:12:42 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: regatta <regatta@gmail.com>
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: FS possible security exposure ?
Message-ID: <20051225101242.GB15577@wiggy.net>
Mail-Followup-To: regatta <regatta@gmail.com>,
	Arjan van de Ven <arjan@infradead.org>,
	linux-kernel@vger.kernel.org
References: <5a3ed5650512250129t434d2b42kc1ebac1c5b308986@mail.gmail.com> <1135503601.2946.6.camel@laptopd505.fenrus.org> <5a3ed5650512250210w3528a8ccsb4df2c3a23863c40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3ed5650512250210w3528a8ccsb4df2c3a23863c40@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously regatta wrote:
> but if you think about it, how could the system allow the user to
> modify a file that he don't own it and he don't have write privilege
> on the file just because he has write in the parent directory ?

As Arjan explained you are not modifying the file. vim just removes it
and replaces it with a new one.

> Maybe I'm wrong, but is this normal ? please let me know

It is, ans solaris does the same thing.

> BTW: is there any document, article or any page about this so I can
> show it to my boss :)

Any decent posix/unix manual should do.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
