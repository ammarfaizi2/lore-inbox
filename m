Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261255AbTEANjx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261256AbTEANjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:39:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41924 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261255AbTEANjx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:39:53 -0400
Date: Thu, 01 May 2003 05:45:23 -0700 (PDT)
Message-Id: <20030501.054523.98892534.davem@redhat.com>
To: Steve@ChyGwyn.com, steve@gw.chygwyn.com
Cc: linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200305011327.OAA16943@gw.chygwyn.com>
References: <20030421.234303.59654654.davem@redhat.com>
	<200305011327.OAA16943@gw.chygwyn.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Steven Whitehouse <steve@gw.chygwyn.com>
   Date: Thu, 1 May 2003 14:27:08 +0100 (BST)
   
   Its got big again, so I've put it here, if you'd like it in bits rather than
   all one lump, just shout:

Please do this because it's easier for me to evaluate small patches
doing one thing at a time and you're also making modifications to
things outside of decnet.

About update_pmtu().  You are not required to implement this.
All of these places you see dereferencing dst->update_mtu()
know that they have an ipv4/ipv6 route.  Or do you know some
exception to this?
