Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132129AbQKVCV2>; Tue, 21 Nov 2000 21:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132207AbQKVCVT>; Tue, 21 Nov 2000 21:21:19 -0500
Received: from lahmed.Stanford.EDU ([171.65.76.205]:54423 "EHLO
	lahmed.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132129AbQKVCVG>; Tue, 21 Nov 2000 21:21:06 -0500
From: David Hinds <dhinds@lahmed.stanford.edu>
Date: Tue, 21 Nov 2000 17:50:11 -0800
To: Horst von Brand <vonbrand@sleipnir.valparaiso.cl>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
Message-ID: <20001121175011.C18265@lahmed.stanford.edu>
In-Reply-To: <dhinds@lahmed.stanford.edu> <200011220144.eAM1iUf08680@sleipnir.valparaiso.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200011220144.eAM1iUf08680@sleipnir.valparaiso.cl>; from vonbrand@sleipnir.valparaiso.cl on Tue, Nov 21, 2000 at 10:44:30PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 10:44:30PM -0300, Horst von Brand wrote:
> 
> If you have a laptop with an assortment of cards, you might want to have
> the generic builtin and the cards themselves as modules.

No, that's ok, and that's supported with the current config scripts.

The original question was about having the generic code built in, but
the socket driver (yenta) as a module.  The socket driver needs to be
loaded regardless of what cards you're using.  So I think having one
in the kernel and the other as a module is of limited utility.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
