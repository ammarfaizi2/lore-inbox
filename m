Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130615AbRCISyA>; Fri, 9 Mar 2001 13:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130617AbRCISxu>; Fri, 9 Mar 2001 13:53:50 -0500
Received: from waste.org ([209.173.204.2]:55314 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S130615AbRCISxh>;
	Fri, 9 Mar 2001 13:53:37 -0500
Date: Fri, 9 Mar 2001 12:52:45 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Helge Hafting <helgehaf@idb.hist.no>, Manoj Sontakke <manojs@sasken.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: quicksort for linked list
In-Reply-To: <200103091152.MAA31645@cave.bitwizard.nl>
Message-ID: <Pine.LNX.4.30.0103091240130.5548-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, Rogier Wolff wrote:

> Quicksort however is an algorithm that is recursive. This means that
> it can use unbounded amounts of stack -> This is not for the kernel.

It is of course bounded by the input size, but yes, it can use O(n)
additional memory in the worst case. There's no particular reason this
memory has to be on the stack - it's just convenient.

> Isn't it easier to do "insertion sort": Keep the lists sorted, and
> insert the item at the right place when you get the new item.

Assuming you get your items in sorted order, this is also O(N^2).

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

