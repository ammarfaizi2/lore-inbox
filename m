Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTEGI4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 04:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263012AbTEGI4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 04:56:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41856 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S263011AbTEGI4B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 04:56:01 -0400
Date: Wed, 07 May 2003 01:00:59 -0700 (PDT)
Message-Id: <20030507.010059.39173270.davem@redhat.com>
To: chas@cmf.nrl.navy.mil
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][ATM] clip locking and more atmvcc cleanup
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305070026.h470QP503306@relax.cmf.nrl.navy.mil>
References: <200305070026.h470QP503306@relax.cmf.nrl.navy.mil>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: chas williams <chas@cmf.nrl.navy.mil>
   Date: Tue, 6 May 2003 20:26:25 -0400
   
   [ATM]: clip should lock the individual table entires
 ...
   [ATM]: listenq and backlog are redundant with existing sk members
          (a 'listen' socket never recv's data so you dont typically
          need a seperate listenq -- even for atm)
   
Applied, thanks.
