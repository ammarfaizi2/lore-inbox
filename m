Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277038AbRJKW6w>; Thu, 11 Oct 2001 18:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277034AbRJKW6n>; Thu, 11 Oct 2001 18:58:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:24761 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S277029AbRJKW6i>;
	Thu, 11 Oct 2001 18:58:38 -0400
Date: Thu, 11 Oct 2001 18:59:03 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Christian Ullrich <chris@chrullrich.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Vincent Sweeney <v.sweeney@dexterus.com>, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Subject: Re: Partitioning problems in 2.4.11
In-Reply-To: <20011012003148.B435@christian.chrullrich.de>
Message-ID: <Pine.GSO.4.21.0110111854080.24742-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Oct 2001, Christian Ullrich wrote:

> a) -10-ac11, -10-ac12 and -12 with your patch all behave like -11.

_Ouch_.  So even bread()-based variant fails to read extended partition
table in some cases.

Hmm... Just in case - what processor are you using?

