Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287631AbSAVBKK>; Mon, 21 Jan 2002 20:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288092AbSAVBKA>; Mon, 21 Jan 2002 20:10:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44722 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287631AbSAVBJq>;
	Mon, 21 Jan 2002 20:09:46 -0500
Date: Mon, 21 Jan 2002 17:07:45 -0800 (PST)
Message-Id: <20020121.170745.52090023.davem@redhat.com>
To: andrea@suse.de
Cc: reid.hekman@ndsu.nodak.edu, linux-kernel@vger.kernel.org, akpm@zip.com.au,
        alan@lxorg.ukuu.org
Subject: Re: Athlon PSE/AGP Bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020122013743.M8292@athlon.random>
In-Reply-To: <20020121175410.G8292@athlon.random>
	<20020121.141931.105134927.davem@redhat.com>
	<20020122013743.M8292@athlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Tue, 22 Jan 2002 01:37:43 +0100

   On Mon, Jan 21, 2002 at 02:19:31PM -0800, David S. Miller wrote:
   > That's not true, see the ptrace() helper code.  Russell King pointed
   > this out to me last week and it's on my TODO list to fix it up.
   
   Where? :) ptrace doesn't change pagetables, no need to flush any tlb in
   ptrace.
   
egrep flush_*_page kernel/ptrace.c:access_process_vm()
