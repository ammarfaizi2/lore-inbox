Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136208AbRASA74>; Thu, 18 Jan 2001 19:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136255AbRASA7r>; Thu, 18 Jan 2001 19:59:47 -0500
Received: from palrel3.hp.com ([156.153.255.226]:50960 "HELO palrel3.hp.com")
	by vger.kernel.org with SMTP id <S136208AbRASA72>;
	Thu, 18 Jan 2001 19:59:28 -0500
Message-ID: <3A67916E.4D41444E@cup.hp.com>
Date: Thu, 18 Jan 2001 16:59:26 -0800
From: Rick Jones <raj@cup.hp.com>
Organization: the Unofficial HP
X-Mailer: Mozilla 4.75 [en] (X11; U; HP-UX B.11.00 9000/785)
X-Accept-Language: en
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: [Fwd: Is sendfile all that sexy? (fwd)]]
In-Reply-To: <20010118212441.E28276@athlon.random> <200101182037.XAA08671@ms2.inr.ac.ru> <20010118220428.G28276@athlon.random> <20010118192758.A2656@zalem.puupuu.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> 
> On Thu, Jan 18, 2001 at 10:04:28PM +0100, Andrea Arcangeli wrote:
> > NAGLE algorithm is only one, CORK algorithm is another different algorithm. So
> > probably it would be not appropriate to mix CORK and NAGLE under the name
> > "CONTROL_NAGLING", but certainly I agree they could stay together under another
> > name ;).
> 
> TCP_FLOW_CONTROL ?

then folks would think you were controlling the congestion or "classic"
windows. what alal these things do is affect segmentation, so perhaps
TCP_SEGMENT_CONTROL or something to that effect, if anything.

rickjones
-- 
ftp://ftp.cup.hp.com/dist/networking/misc/rachel/
these opinions are mine, all mine; HP might not want them anyway... :)
feel free to email, OR post, but please do NOT do BOTH...
my email address is raj in the cup.hp.com domain...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
