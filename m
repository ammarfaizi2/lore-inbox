Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132722AbRDQXER>; Tue, 17 Apr 2001 19:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132731AbRDQXD5>; Tue, 17 Apr 2001 19:03:57 -0400
Received: from t2.redhat.com ([199.183.24.243]:9973 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S132722AbRDQXDz>; Tue, 17 Apr 2001 19:03:55 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010417222555.L805@mea-ext.zmailer.org> 
In-Reply-To: <20010417222555.L805@mea-ext.zmailer.org>  <20010417190405.PTFU6564.tomts8-srv.bellnexxia.net@mail.vger.kernel.org> <Pine.LNX.4.33.0104171212520.960-100000@batman.zarzycki.org> 
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Dave Zarzycki <dave@zarzycki.org>, linux-kernel@vger.kernel.org
Subject: Re: Your response is requested 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 18 Apr 2001 00:03:41 +0100
Message-ID: <11637.987548621@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


matti.aarnio@zmailer.org said:
>   Actually not.  Either your MTA, or your MUA did that.
>   I got:
> 	From:   J. I.
>   This particular detail -- when to add canonical domain to e.g. From:
>   address, and when not -- is implemented rather fuzzily usually.. 

I'm in the "if it arrives unqualified by SMTP from !localhost, reject it"
camp. I certainly can't think of a single case where it's appropriate to
accept it _and_ qualify it with the local domain in that case.

--
dwmw2


