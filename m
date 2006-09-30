Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751864AbWI3UNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864AbWI3UNW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751917AbWI3UNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:13:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:238 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751864AbWI3UNW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:13:22 -0400
Date: Sat, 30 Sep 2006 13:13:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Eric Rannaud" <eric.rannaud@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Linus Torvalds" <torvalds@osdl.org>,
       mingo@elte.hu, nagar@watson.ibm.com
Subject: Re: BUG-lockdep and freeze (was: Arrr! Linux 2.6.18)
Message-Id: <20060930131310.0d6494e7.akpm@osdl.org>
In-Reply-To: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
References: <5f3c152b0609301220p7a487c7dw456d007298578cd7@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 21:20:58 +0200
"Eric Rannaud" <eric.rannaud@gmail.com> wrote:

> On  a 16-way Opteron (8 dual-core 880) with 8GB of RAM, vanilla 2.6.18
> crashes early on boot with a BUG.

omg what a mess.  Have you tried it with lockdep disabled in config?
