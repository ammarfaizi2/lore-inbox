Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUAFMiz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbUAFMiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:38:55 -0500
Received: from colin2.muc.de ([193.149.48.15]:50449 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261885AbUAFMix (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:38:53 -0500
Date: 6 Jan 2004 13:39:47 +0100
Date: Tue, 6 Jan 2004 13:39:47 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Libor Vanek <libor@conet.cz>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: 2.6.0-mm1 - kernel panic (VFS bug?)
Message-ID: <20040106123947.GA17607@colin2.muc.de>
References: <1aQy3-2y1-7@gated-at.bofh.it> <m3znd139ur.fsf@averell.firstfloor.org> <3FFAAB91.6090207@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFAAB91.6090207@conet.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK - what's correct implementation? Do a "char * tmp_path" and kmalloc it?

Use getname()/putname()

-Andi
