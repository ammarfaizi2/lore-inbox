Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316974AbSFKOEh>; Tue, 11 Jun 2002 10:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316976AbSFKOEg>; Tue, 11 Jun 2002 10:04:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60101 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316974AbSFKOEf>;
	Tue, 11 Jun 2002 10:04:35 -0400
Date: Tue, 11 Jun 2002 07:00:18 -0700 (PDT)
Message-Id: <20020611.070018.111260341.davem@redhat.com>
To: remedy@mirotel.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: sysctl net.ipv4.icmp_default_ttl
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <02061116333800.01217@fortress.mirotel.net>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


What is this useful for?  You can control the TTL in the APP and now
you've broken this in that you'll override the application selected
socket TTL.  That is broken.

Also you messed up the patch, it is a patch of a patch instead of
before/after versions of the files.
