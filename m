Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284970AbSBGGwn>; Thu, 7 Feb 2002 01:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284987AbSBGGwc>; Thu, 7 Feb 2002 01:52:32 -0500
Received: from pizda.ninka.net ([216.101.162.242]:24471 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284970AbSBGGwO>;
	Thu, 7 Feb 2002 01:52:14 -0500
Date: Wed, 06 Feb 2002 22:50:10 -0800 (PST)
Message-Id: <20020206.225010.81469792.davem@redhat.com>
To: akpm@zip.com.au
Cc: marcelo@conectiva.com.br, manfred@colorfullife.com, andrea@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] VM_IO fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C621B44.10C424B9@zip.com.au>
In-Reply-To: <3C621B44.10C424B9@zip.com.au>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@zip.com.au>
   Date: Wed, 06 Feb 2002 22:14:28 -0800
   
   It's simpler to make VM_IO default to `on', and to only clear it
   in places where we know that it's safe to dump the memory to a
   core file, and where it's safe to PTRACE_PEEKUSR it.  That's
   what this patch does.

I completely agree with this change.
