Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbTABEtG>; Wed, 1 Jan 2003 23:49:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbTABEtG>; Wed, 1 Jan 2003 23:49:06 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28090 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266095AbTABEtE>;
	Wed, 1 Jan 2003 23:49:04 -0500
Date: Wed, 01 Jan 2003 20:50:03 -0800 (PST)
Message-Id: <20030101.205003.37279830.davem@redhat.com>
To: rth@twiddle.net
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, schwidefsky@de.ibm.com, ak@suse.de,
       paulus@samba.org, rmk@arm.linux.org.uk
Subject: Re: [PATCH] Modules 3/3: Sort sections
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030101205404.B30272@twiddle.net>
References: <20030102030044.D066C2C05E@lists.samba.org>
	<20030101205404.B30272@twiddle.net>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Richard Henderson <rth@twiddle.net>
   Date: Wed, 1 Jan 2003 20:54:04 -0800
   
   Incidentally, why do we do strstr(name, ".init") instead
   of strncmp(name, ".init", 5)?  Is there any particular
   need for the .init to come at the end?

I think this is to get .foo.init sections.
