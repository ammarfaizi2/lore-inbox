Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262236AbVBXLxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbVBXLxX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 06:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVBXLxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 06:53:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:37808 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262236AbVBXLxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 06:53:21 -0500
Date: Thu, 24 Feb 2005 03:52:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mauricio Lin <mauriciolin@gmail.com>
Cc: hugh@veritas.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       rrebel@whenu.com, marcelo.tosatti@cyclades.com, nickpiggin@yahoo.com.au
Subject: Re: [PATCH] A new entry for /proc
Message-Id: <20050224035255.6b5b5412.akpm@osdl.org>
In-Reply-To: <3f250c710502240343563c5cb0@mail.gmail.com>
References: <20050106202339.4f9ba479.akpm@osdl.org>
	<Pine.LNX.4.44.0501081917020.4949-100000@localhost.localdomain>
	<3f250c710502220513179b606a@mail.gmail.com>
	<3f250c71050224003110e74704@mail.gmail.com>
	<20050224010947.774628f3.akpm@osdl.org>
	<3f250c710502240343563c5cb0@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Lin <mauriciolin@gmail.com> wrote:
>
> But can i use jiffies to measure this kind of performance??? AFAIK, if
>  it is more efficient, then it is faster, right? How can I know how
>  fast it is? Any idea?

umm, 

time ( for i in $(seq 100); do; cat /proc/nnn/smaps; done > /dev/null )

?
