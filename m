Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274634AbRIYLFA>; Tue, 25 Sep 2001 07:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRIYLEv>; Tue, 25 Sep 2001 07:04:51 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35852 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S274634AbRIYLEn>; Tue, 25 Sep 2001 07:04:43 -0400
Date: Tue, 25 Sep 2001 13:05:07 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] OOM aware applications
Message-ID: <20010925130507.E1390@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3BB013D3.6060408@wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3BB013D3.6060408@wipro.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2001, BALBIR SINGH wrote:

>    In the code, I see
> 
>    points *= 2 and points /= 4 in a few places, recommend changing them to
> 
>    points <<= 1 and points >>= 2 to help the compiler generate better code

Does your compiler really write different code for *= 2 and <<= 1? If
so, try -O :-)

My gcc writes addl %eax,%eax for either case.

-- 
Matthias Andree

"Those who give up essential liberties for temporary safety deserve
neither liberty nor safety." - Benjamin Franklin
