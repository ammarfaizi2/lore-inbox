Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288752AbSAUW0O>; Mon, 21 Jan 2002 17:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288768AbSAUW0G>; Mon, 21 Jan 2002 17:26:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:11697 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288752AbSAUWZW>;
	Mon, 21 Jan 2002 17:25:22 -0500
Date: Mon, 21 Jan 2002 14:23:20 -0800 (PST)
Message-Id: <20020121.142320.123999571.davem@redhat.com>
To: akpm@zip.com.au
Cc: andrea@suse.de, reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C4C5B26.3A8512EF@zip.com.au>
In-Reply-To: <20020121.053724.124970557.davem@redhat.com>
	<20020121175410.G8292@athlon.random>
	<3C4C5B26.3A8512EF@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Mon, 21 Jan 2002 10:17:10 -0800

   Andrea Arcangeli wrote:
   > I think this is a very very minor issue, I doubt anybody ever triggered
   > it in real life with linux.
   
   It is said that the crashes cease when the `nopentium' option
   is used, so it does appear that something is up.
   
   I does seem that the nVidia driver is usually involved.

I think this is all "just so happens" personally, and all the that
turning off the large pages really does is change the timings so that
whatever bug is really present simply becomes a heisenbug.
