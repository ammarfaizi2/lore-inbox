Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264080AbRFKXYK>; Mon, 11 Jun 2001 19:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264081AbRFKXYA>; Mon, 11 Jun 2001 19:24:00 -0400
Received: from babel.apana.org.au ([202.12.88.4]:1284 "EHLO babel.apana.org.au")
	by vger.kernel.org with ESMTP id <S264080AbRFKXXn>;
	Mon, 11 Jun 2001 19:23:43 -0400
Date: Tue, 12 Jun 2001 09:23:05 +1000
From: johna@babel.apana.org.au
To: linux-kernel@vger.kernel.org
Subject: Re: Driver for ADC 7841 Analogue Digital Converter
Message-ID: <20010612092305.A365@babel.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've put this driver on my web page at :

http://phaedra.apana.org.au/johna

But, my original comments ommitted the fact that there is a data in
pin, as well as a data out pin. The code itself is fine, and reflects
this.

The correct pin allocations are :

port 0x278

bit 0, pin 2, Clock
bit 1, pin 3, Chip Select
bit 2, pin 4, Data out to ADC
bits 3-7 user available

port 0x279

bit 3, pin 15, Busy
bit 4, pin 13, Data in from ADC
bits 5-7 user available

And I've changed the code on my home page to reflect this.

Gatic,

-- 
John August

Actions speak louder than spending habits.
