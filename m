Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261907AbTBSV1I>; Wed, 19 Feb 2003 16:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261908AbTBSV1I>; Wed, 19 Feb 2003 16:27:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3779 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261907AbTBSV1H>;
	Wed, 19 Feb 2003 16:27:07 -0500
Date: Wed, 19 Feb 2003 13:20:48 -0800 (PST)
Message-Id: <20030219.132048.35036153.davem@redhat.com>
To: jgarzik@pobox.com
Cc: toml@us.ibm.com, linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] IPSec protocol application order
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030219212950.GC4977@gtf.org>
References: <1045687340.3419.14.camel@tomlt2.austin.ibm.com>
	<20030219212950.GC4977@gtf.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@pobox.com>
   Date: Wed, 19 Feb 2003 16:29:50 -0500
   
   hmmm... do you really need to duplicate all that code, just to define
   the order?
   
It's not even a kernel issue as Alexey and myself said in other
emails, the kernel merely does what the user application asks it to do
