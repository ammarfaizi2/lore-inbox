Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289796AbSAWLl1>; Wed, 23 Jan 2002 06:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289802AbSAWLlK>; Wed, 23 Jan 2002 06:41:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9344 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289796AbSAWLlB>;
	Wed, 23 Jan 2002 06:41:01 -0500
Date: Wed, 23 Jan 2002 03:39:33 -0800 (PST)
Message-Id: <20020123.033933.41633002.davem@redhat.com>
To: riel@conectiva.com.br
Cc: vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org,
        andrea@suse.de, alan@redhat.com, akpm@zip.com.au,
        vherva@niksula.hut.fi
Subject: Re: Athlon/AGP issue update
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0201230829430.32617-100000@imladris.surriel.com>
In-Reply-To: <20020123.022441.21593293.davem@redhat.com>
	<Pine.LNX.4.33L.0201230829430.32617-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Wed, 23 Jan 2002 08:31:32 -0200 (BRST)
   
   This means that when using 4kB pages instead of 4MB
   pages the agp data is "fenced off" from the other
   kernel data.

Kernel data this explains, thank you.

But on the user side, we map these GART-mapped pages into user space
with the cacheable bit set.
