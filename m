Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130492AbRCIMJy>; Fri, 9 Mar 2001 07:09:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130497AbRCIMJe>; Fri, 9 Mar 2001 07:09:34 -0500
Received: from nef.ens.fr ([129.199.96.32]:22029 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S130491AbRCIMJZ>;
	Fri, 9 Mar 2001 07:09:25 -0500
Date: Fri, 9 Mar 2001 13:09:02 +0100
From: Thomas Pornin <Thomas.Pornin@ens.fr>
To: R.E.Wolff@bitwizard.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: quicksort for linked list
Message-ID: <20010309130902.A24249@bolet.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200103091152.MAA31645@cave.bitwizard.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200103091152.MAA31645@cave.bitwizard.nl> you write:
> Quicksort however is an algorithm that is recursive. This means that
> it can use unbounded amounts of stack -> This is not for the kernel.

Maybe a heapsort, then. It is guaranteed O(n*log n), even for worst
case, and non-recursive. Yet it implies a significantly larger amount of
comparisons than quicksort (about twice, I think).

Insertion sort will be better anyway for small sets of data (for 5 or
less elements).


	--Thomas Pornin
