Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272280AbRHXReX>; Fri, 24 Aug 2001 13:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272279AbRHXReO>; Fri, 24 Aug 2001 13:34:14 -0400
Received: from t2.redhat.com ([199.183.24.243]:26611 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S272278AbRHXReE>; Fri, 24 Aug 2001 13:34:04 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <2606707256.998677533@[10.132.112.53]> 
In-Reply-To: <2606707256.998677533@[10.132.112.53]>  <14764.998658214@redhat.com> 
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Cc: Tim Walberg <twalberg@mindspring.com>,
        "J. Imlay" <jimlay@u.washington.edu>, linux-kernel@vger.kernel.org
Subject: Re: macro conflict 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Aug 2001 18:34:16 +0100
Message-ID: <6242.998674456@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


linux-kernel@alex.org.uk said:
>  Will this work with things like
> void test(unsigned int foo, char bar) {
> 	printf ("%d %d\n", min(foo, 10), min (bar, 20)); }
> Surely one of those must BUG().

Well, ideally both of them would BUG() and the user would have to explicitly
cast one (or both) of the arguments so the types match. But as Keith 
pointed out, it won't work.

--
dwmw2


