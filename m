Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289340AbSAJFbH>; Thu, 10 Jan 2002 00:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSAJFa5>; Thu, 10 Jan 2002 00:30:57 -0500
Received: from pizda.ninka.net ([216.101.162.242]:10624 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289340AbSAJFau>;
	Thu, 10 Jan 2002 00:30:50 -0500
Date: Wed, 09 Jan 2002 21:29:57 -0800 (PST)
Message-Id: <20020109.212957.59465864.davem@redhat.com>
To: rml@tech9.net
Cc: kevin@koconnor.net, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: lock order in O(1) scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1010640369.5335.289.camel@phantasy>
In-Reply-To: <20020110001002.A13456@arizona.localdomain>
	<1010640369.5335.289.camel@phantasy>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Love <rml@tech9.net>
   Date: 10 Jan 2002 00:26:08 -0500
   
   Not so sure about unlocking.  Ingo?

Unlocking order doesn't matter wrt. ABBA deadlock.
