Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274815AbRJAJxL>; Mon, 1 Oct 2001 05:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274822AbRJAJxB>; Mon, 1 Oct 2001 05:53:01 -0400
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:33296 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S274815AbRJAJws>; Mon, 1 Oct 2001 05:52:48 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Allow net devices to contribute to /dev/random
In-Reply-To: <1001461026.9352.156.camel@phantasy>
	<9or70g$i59$1@abraham.cs.berkeley.edu>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 01 Oct 2001 11:52:21 +0200
In-Reply-To: <9or70g$i59$1@abraham.cs.berkeley.edu> (daw@mozart.cs.berkeley.edu's message of "26 Sep 2001 00:20:32 GMT")
Message-ID: <tgadzbr8kq.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.090001 (Oort Gnus v0.01) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

daw@mozart.cs.berkeley.edu (David Wagner) writes:

> Incrementing the entropy counter based on externally observable
> values is dangerous.

How do you want to collect any entropy with such a requirement in
place?  Computers tend to send out a lot of information on the air.

BTW, I still think that the entropy estimate for mouse movements is
much too high.  And the compression function used probably doesn't
have the intended property.

-- 
Florian Weimer 	                  Florian.Weimer@RUS.Uni-Stuttgart.DE
University of Stuttgart           http://cert.uni-stuttgart.de/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
