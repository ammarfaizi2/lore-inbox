Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132837AbRDDPL5>; Wed, 4 Apr 2001 11:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132836AbRDDPLs>; Wed, 4 Apr 2001 11:11:48 -0400
Received: from mail.inup.com ([194.250.46.226]:26635 "EHLO mailhost.lineo.fr")
	by vger.kernel.org with ESMTP id <S132837AbRDDPLf>;
	Wed, 4 Apr 2001 11:11:35 -0400
Date: Wed, 4 Apr 2001 17:15:42 +0200
From: christophe barbe <christophe.barbe@lineo.fr>
To: Paul Jakma <paulj@itg.ie>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep (D state => load_avrg++)
Message-ID: <20010404171542.A14461@pc8.inup.com>
In-Reply-To: <20010404164858.A14009@pc8.inup.com> <Pine.LNX.4.33.0104041548120.1150-100000@rossi.itg.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0104041548120.1150-100000@rossi.itg.ie>; from paulj@itg.ie on mer, avr 04, 2001 at 17:05:05 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On mer, 04 avr 2001 17:05:05 Paul Jakma wrote:
> imagine a box with a bunch of processes that do almost nothing but
> call on the kernel to do IO. If you only count the runnable state
> towards load_avg then your load_avg will be very low, even though your
> box is swamped - you are ignoring the work of the kernel.
> 
> if you count D towards load_avg then it will reflect this abstract
> 'load' concept more accurately.
> 
> Ie, counting D towards load_avg is a way of taking kernel IO work into
> account when calculating the load average figures.

ok I'm convinced.
And a measure can't be perfect.

Thank you,
Christophe

-- 
Christophe Barbé
Software Engineer
Lineo High Availability Group
42-46, rue Médéric
92110 Clichy - France
phone (33).1.41.40.02.12
fax (33).1.41.40.02.01
www.lineo.com
