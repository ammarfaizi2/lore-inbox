Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265411AbRGBTK4>; Mon, 2 Jul 2001 15:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265413AbRGBTKr>; Mon, 2 Jul 2001 15:10:47 -0400
Received: from cs.columbia.edu ([128.59.16.20]:11245 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S265411AbRGBTKe>;
	Mon, 2 Jul 2001 15:10:34 -0400
Message-Id: <200107021910.PAA27951@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andries.Brouwer@cwi.nl, andrewm@uow.edu.au, torvalds@transmeta.com,
        tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] more SAK stuff 
In-Reply-To: Your message of "Mon, 02 Jul 2001 13:33:01 BST."
             <E15H2sv-0005pG-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 02 Jul 2001 15:10:32 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-> From Alan Cox <alan@lxorguk.ukuu.org.uk> :

> > (a) It does less, namely will not kill processes with uid 0.
> > Ted, any objections?
> 
> That breaks the security guarantee. Suppose I use a setuid app to confuse 
> you into doing something ?

a setuid app only changes euid, doesn't it?


