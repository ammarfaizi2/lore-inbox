Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268492AbTCCJgM>; Mon, 3 Mar 2003 04:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268490AbTCCJgM>; Mon, 3 Mar 2003 04:36:12 -0500
Received: from pizda.ninka.net ([216.101.162.242]:57255 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268492AbTCCJgL>;
	Mon, 3 Mar 2003 04:36:11 -0500
Date: Mon, 03 Mar 2003 01:28:25 -0800 (PST)
Message-Id: <20030303.012825.81834528.davem@redhat.com>
To: latten@austin.ibm.com
Cc: kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: PATCH: IPSec not using padding when Null Encryption
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200302272129.h1RLTJW28434@faith.austin.ibm.com>
References: <200302272129.h1RLTJW28434@faith.austin.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: latten@austin.ibm.com
   Date: Thu, 27 Feb 2003 15:29:19 -0600
   
   Ok, anyway, this fix just pretty much makes sure that
   when Null Encryption or any algorithm with a blocksize less
   than 4 is used, that the ciphertext, any padding, and next-header
   and pad-length fields terminate on a 4-byte boundary.
   I have tested it. Please let me know if all is well. 

Applied, thanks.
