Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261778AbTCQQrq>; Mon, 17 Mar 2003 11:47:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261779AbTCQQrq>; Mon, 17 Mar 2003 11:47:46 -0500
Received: from comtv.ru ([217.10.32.4]:27864 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261778AbTCQQrp>;
	Mon, 17 Mar 2003 11:47:45 -0500
X-Comment-To: wind@cocodriloo.com
To: wind@cocodriloo.com
Cc: Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org,
       akpm@digeo.com
Subject: Re: 2.4 vm, program load, page faulting, ...
References: <20030317151004.GR20188@holomorphy.com>
	<Pine.LNX.4.44.0303171100300.2571-100000@chimarrao.boston.redhat.com>
	<20030317165223.GA11526@wind.cocodriloo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 17 Mar 2003 19:50:04 +0300
In-Reply-To: <20030317165223.GA11526@wind.cocodriloo.com>
Message-ID: <m3hea2gcoz.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> wind  (w) writes:

 w> On Mon, Mar 17, 2003 at 11:01:31AM -0500, Rik van Riel wrote:
 >> On Mon, 17 Mar 2003, William Lee Irwin III wrote:
 >> > On Sat, 15 Mar 2003, Paul Albrecht wrote:
 >> > >> ... Why does the kernel page fault on text pages, present in
 >> the page > >> cache, when a program starts? Couldn't the pte's for
 >> text present in the > >> page cache be resolved when they're
 >> mapped to memory?
 >> > 

 w> You should ask Andrew about his patch to do exactly that: he
 w> forced all PROC_EXEC mmaps to be nonlinear-mapped and this forced
 w> all programs to suck entire binaries into memory...  I recall he
 w> saw at least 25% improvement at launching gnome.

they talked about pages _already present_ in pagecache.


