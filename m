Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137092AbREKJ5C>; Fri, 11 May 2001 05:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137093AbREKJ4w>; Fri, 11 May 2001 05:56:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1431 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S137092AbREKJ4l>;
	Fri, 11 May 2001 05:56:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15099.46931.914571.475632@pizda.ninka.net>
Date: Fri, 11 May 2001 02:56:35 -0700 (PDT)
To: R.E.Wolff@BitWizard.nl (Rogier Wolff)
Cc: linux-kernel@vger.kernel.org
Subject: Re: Source code compatibility in Stable series????
In-Reply-To: <200105110947.LAA18167@cave.bitwizard.nl>
In-Reply-To: <200105110947.LAA18167@cave.bitwizard.nl>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Rogier Wolff writes:
 > It seems that in 2.4.4 suddenly the function "skb_cow" no longer
 > returns the modified skb, but it retuns and integer for
 > succes/failure.
 > 
 > This means that for networking modules requiring this function, there
 > is no source code compatibilty between 2.4.3 and 2.4.4.

And skb_datarefp went away too, in fact a ton of things changes.

Just deal with it.

Later,
David S. Miller
davem@redhat.com
