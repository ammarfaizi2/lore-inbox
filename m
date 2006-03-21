Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751331AbWCUTnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751331AbWCUTnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 14:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCUTnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 14:43:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:21451 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965092AbWCUTnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 14:43:06 -0500
Subject: Re: [PATCH][5/8] proc: export mlocked pages info through
	"/proc/meminfo: Wired"
From: Arjan van de Ven <arjan@infradead.org>
To: Stone Wang <pwstone@gmail.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
In-Reply-To: <bc56f2f0603210733vc3ce132p@mail.gmail.com>
References: <bc56f2f0603200537i7b2492a6p@mail.gmail.com>
	 <441FEFC7.5030109@yahoo.com.au> <bc56f2f0603210733vc3ce132p@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 20:43:00 +0100
Message-Id: <1142970181.3077.103.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 10:33 -0500, Stone Wang wrote:
> The list potentially could have more wider use.
> 
> For example, kernel-space locked/pinned pages could be placed on the list too
> (while mlocked pages are locked/pinned by system calls from user-space).

then please call it pinned_list or locked_down_list or so ;)


