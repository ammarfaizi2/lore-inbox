Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287612AbSANQ16>; Mon, 14 Jan 2002 11:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287657AbSANQ1r>; Mon, 14 Jan 2002 11:27:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33943 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S287615AbSANQ1n>;
	Mon, 14 Jan 2002 11:27:43 -0500
Date: Mon, 14 Jan 2002 08:26:21 -0800 (PST)
Message-Id: <20020114.082621.105170691.davem@redhat.com>
To: greearb@candelatech.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Multi-packet read/write for packet sockets?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C430323.6060707@candelatech.com>
In-Reply-To: <3C430323.6060707@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Use mmap() on packet sockets... it is even faster than the
thing which you propose.

