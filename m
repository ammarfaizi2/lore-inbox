Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270248AbTHQOi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 10:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTHQOi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 10:38:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:25357 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S270248AbTHQOi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 10:38:26 -0400
Date: Mon, 18 Aug 2003 00:37:29 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Matt Mackall <mpm@selenic.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, Jamie Lokier <jamie@shareable.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, <davem@redhat.com>
Subject: Re: [RFC][PATCH] Make cryptoapi non-optional?
In-Reply-To: <20030816155110.GH325@waste.org>
Message-ID: <Mutt.LNX.4.44.0308180036570.1683-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003, Matt Mackall wrote:

> Yes, but it's introduced by the requirements imposed by cryptoapi. The
> current code uses the stack (though currently rather a lot of it),
> which lets it be fully re-entrant. Not an option with cryptoapi.

This will be possible with your api flags patch, right?


- James
-- 
James Morris
<jmorris@intercode.com.au>

