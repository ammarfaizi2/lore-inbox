Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292092AbSBYSnB>; Mon, 25 Feb 2002 13:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291825AbSBYSmn>; Mon, 25 Feb 2002 13:42:43 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:37105 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S292092AbSBYSm0>; Mon, 25 Feb 2002 13:42:26 -0500
Message-ID: <3C7A8555.4EB80882@pp.inet.fi>
Date: Mon, 25 Feb 2002 20:41:25 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: mailerror@hushmail.com
CC: linux-kernel@vger.kernel.org
Subject: Re: loop under 2.2.20 - relative block support?
In-Reply-To: <200202251608.g1PG8QH83933@mailserver4.hushmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mailerror@hushmail.com wrote:
> On Sat, 23 Feb 2002 21:47:56 +0200, Jari Ruusu <jari.ruusu@pp.inet.fi> wrote:
> >Kerneli patches use block size dependant IV computation (also called "time
> >bomb" IV). Shit hits the fan when you move files to a device with different
> >block size. Search linux-crypto archives for more information.
> 
> Aha. So if I moved the loopback file onto a partition with the same blocksize
> again, it would all be fine?

If you can move original (unmodified) loop file to same block size, same
kernel version, then yes. If you mounted it rw, then your "time bomb"
exploded on your face.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
