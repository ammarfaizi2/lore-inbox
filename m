Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264877AbSLGWfk>; Sat, 7 Dec 2002 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264883AbSLGWfk>; Sat, 7 Dec 2002 17:35:40 -0500
Received: from pizda.ninka.net ([216.101.162.242]:25218 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264877AbSLGWfj>;
	Sat, 7 Dec 2002 17:35:39 -0500
Date: Sat, 07 Dec 2002 14:40:04 -0800 (PST)
Message-Id: <20021207.144004.45605764.davem@redhat.com>
To: jgarzik@pobox.com
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [RFC][PATCH] net drivers and cache alignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DF2781D.3030209@pobox.com>
References: <3DF2781D.3030209@pobox.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Can't the cacheline_aligned attribute be applied to individual
struct members?  I remember doing this for thread_struct on
sparc ages ago.
