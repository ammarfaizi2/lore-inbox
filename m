Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSIAIzs>; Sun, 1 Sep 2002 04:55:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSIAIzs>; Sun, 1 Sep 2002 04:55:48 -0400
Received: from pizda.ninka.net ([216.101.162.242]:3009 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S315721AbSIAIzs>;
	Sun, 1 Sep 2002 04:55:48 -0400
Date: Sun, 01 Sep 2002 01:52:04 -0700 (PDT)
Message-Id: <20020901.015204.124081360.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       aurora-sparc-devel@linuxpower.org
Subject: Re: [PATCH] sparc32: wrong type of nlink_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901085524.GB32122@louise.pinerecords.com>
References: <20020901085524.GB32122@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sun, 1 Sep 2002 10:55:24 +0200

   Against 2.4.20-pre5 - fix up the type of nlink_t. This makes jfs and
   reiserfs stop complaining about comparisons always turning up false
   due to limited range of data type.

If you change this, you change the types exported to userspace
which will break everything.
