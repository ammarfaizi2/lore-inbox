Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261268AbSJ1O3x>; Mon, 28 Oct 2002 09:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261271AbSJ1O3x>; Mon, 28 Oct 2002 09:29:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64682 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261268AbSJ1O3w>;
	Mon, 28 Oct 2002 09:29:52 -0500
Date: Mon, 28 Oct 2002 06:26:48 -0800 (PST)
Message-Id: <20021028.062648.16072775.davem@redhat.com>
To: hugh@veritas.com
Cc: alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk, willy@debian.org,
       akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210281429160.10214-100000@localhost.localdomain>
References: <20021028.061059.38206858.davem@redhat.com>
	<Pine.LNX.4.44.0210281429160.10214-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Hugh Dickins <hugh@veritas.com>
   Date: Mon, 28 Oct 2002 14:35:15 +0000 (GMT)
   
   I like your patch, but what has changed?  Are those platforms which
   were using flush_page_to_ram() now committed to its elimination?
   Or have they already replaced it (not seen in your patch)?
   
No they have to fix their port to use the supported interface,
simply.  That's why I added the "#error " lines telling the person
compiling on such a platform what needs to happen.

   
