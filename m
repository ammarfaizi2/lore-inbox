Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288447AbSAQIyd>; Thu, 17 Jan 2002 03:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288395AbSAQIyX>; Thu, 17 Jan 2002 03:54:23 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:43511 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S288342AbSAQIyH>; Thu, 17 Jan 2002 03:54:07 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020116204345.A22055@thyrsus.com> 
In-Reply-To: <20020116204345.A22055@thyrsus.com>  <20020116164758.F12306@thyrsus.com> <esr@thyrsus.com> <200201162156.g0GLukCj017833@tigger.cs.uni-dortmund.de> <20020116164758.F12306@thyrsus.com> <26592.1011230762@redhat.com> 
To: esr@thyrsus.com
Cc: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Jan 2002 08:53:59 +0000
Message-ID: <3515.1011257639@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
>  Wha's happened is that I, and others, have merged in a lot of
> information  about what cards can be plugged into which platforms.
> That information has been turned into dependency/visibility rules. 

> Here are some examples from the network cards... 

Hmmm, yes. I think I see at least two errors in that small selection, if I
understand it correctly. But as these are obviously behavioural changes, and
you've said you won't make behavioural changes in the first push of CML2 to
Linus, we can safely ignore them for now - they're lined up for your second
wave of patches, right?

This is why the behavioural changes must be separate from the initial
conversion, btw. They _do_ need separate attention from the gruntwork of
translating CML1 to CML2.

--
dwmw2


