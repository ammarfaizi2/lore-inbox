Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262576AbSJQXLj>; Thu, 17 Oct 2002 19:11:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSJQXLi>; Thu, 17 Oct 2002 19:11:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:22208 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262576AbSJQXK1>;
	Thu, 17 Oct 2002 19:10:27 -0400
Date: Thu, 17 Oct 2002 16:08:55 -0700 (PDT)
Message-Id: <20021017.160855.85416723.davem@redhat.com>
To: chris@wirex.com
Cc: daw@mozart.cs.berkeley.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove sys_security
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017160436.D26442@figure1.int.wirex.com>
References: <aonbj9$pun$1@abraham.cs.berkeley.edu>
	<20021017.153627.132905359.davem@redhat.com>
	<20021017160436.D26442@figure1.int.wirex.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Chris Wright <chris@wirex.com>
   Date: Thu, 17 Oct 2002 16:04:36 -0700
   
   the photographer would like it if the mp3 player can't remove files
   in ~/photos/ when it plays a malicious .mp3 file.
   
LSM doesn't provide anything in this area which can't be done
today.  You can protect that directory from malicious programs
today with file/dir protections and running programs with a different
capability set or even with a different euid/egid for file accesses.
