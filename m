Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268141AbTBSHPq>; Wed, 19 Feb 2003 02:15:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbTBSHPq>; Wed, 19 Feb 2003 02:15:46 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33470 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268141AbTBSHPq>;
	Wed, 19 Feb 2003 02:15:46 -0500
Date: Tue, 18 Feb 2003 23:04:02 -0800 (PST)
Message-Id: <20030218.230402.113318233.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: maxk@qualcomm.com, kuznet@ms2.inr.ac.ru, jt@bougret.hpl.hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030219035559.7527A2C079@lists.samba.org>
References: <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com>
	<20030219035559.7527A2C079@lists.samba.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Wed, 19 Feb 2003 14:54:21 +1100
   
   Firstly, the owner field should probably be in struct proto_ops not
   struct socket, where the function pointers are.

I think this is one of Alexey's main problems with the
patch.
