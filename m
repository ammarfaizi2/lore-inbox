Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262718AbREOKGm>; Tue, 15 May 2001 06:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262719AbREOKGW>; Tue, 15 May 2001 06:06:22 -0400
Received: from t2.redhat.com ([199.183.24.243]:52719 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262718AbREOKGN>; Tue, 15 May 2001 06:06:13 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.21.0105150134190.32493-100000@freak.distro.conectiva> 
In-Reply-To: <Pine.LNX.4.21.0105150134190.32493-100000@freak.distro.conectiva> 
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] remove page_launder() from bdflush 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 May 2001 11:05:50 +0100
Message-ID: <8889.989921150@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



marcelo@conectiva.com.br said:
>  There is no reason why bdflush should call page_launder().
> Its pretty obvious that bdflush's job is to only write out _buffers_. 
> Under my tests this patch makes things faster. 

Oh good. ISTR last time I looked at implementing CONFIG_BLK_DEV I got as far
as trying to remove bdflush() before getting confused at finding
page_launder() in it, and going on to more important things.

--
dwmw2


