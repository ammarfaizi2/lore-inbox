Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTEFEqx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTEFEqw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:46:52 -0400
Received: from rth.ninka.net ([216.101.162.244]:35765 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262373AbTEFEqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:46:49 -0400
Subject: Re: [PATCH][v850]  Add leading underline to new linker-script
	symbols on the v850
From: "David S. Miller" <davem@redhat.com>
To: Miles Bader <miles@gnu.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030506030925.388CC3760@mcspd15.ucom.lsi.nec.co.jp>
References: <20030506030925.388CC3760@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052192261.983.10.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2003 20:37:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why are you submitting patches that define
flush_page_to_ram() to anything?

That interface is deleted in 2.5.x, no platform
should define it and nothing in the kernel invokes
it.

If you need something like that internally, use a
name such as v850_flush_page_to_ram().

