Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbUAENP5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 08:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264256AbUAENP5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 08:15:57 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:63366 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id S264252AbUAENPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 08:15:55 -0500
Date: Mon, 5 Jan 2004 05:16:02 -0800
From: Paul Jackson <pj@sgi.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: ak@muc.de, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] disable gcc warnings of sign/unsigned comparison
Message-Id: <20040105051602.2fb8d49f.pj@sgi.com>
In-Reply-To: <20040105014122.GW10569@fs.tum.de>
References: <19ahq-7Rg-11@gated-at.bofh.it>
	<19eEs-5lC-15@gated-at.bofh.it>
	<19kgS-4HT-19@gated-at.bofh.it>
	<m3pte3i17t.fsf@averell.firstfloor.org>
	<20040105014122.GW10569@fs.tum.de>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It was a bug in some _prerelease_ versions of gcc 3.3 SuSE decided to 
> ship in a release of their distribution.

That matches my observations, as I noted an earlier reply on lkml,
when I recommended against accepting my own patch, on the grounds
that we shouldn't pollute the Makefile with exceptions that only
applied to people running the gcc in a particular SuSE distro.

Good.  Thanks for the confirmation.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
