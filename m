Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129191AbRBEM2P>; Mon, 5 Feb 2001 07:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129352AbRBEM2F>; Mon, 5 Feb 2001 07:28:05 -0500
Received: from switch.datavakten.no ([195.159.40.3]:15117 "HELO
	switch.datavakten.no") by vger.kernel.org with SMTP
	id <S129191AbRBEM1r> convert rfc822-to-8bit; Mon, 5 Feb 2001 07:27:47 -0500
To: Pat Verner <pat@isis.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.[01] and BogoMips
In-Reply-To: <4.3.2.7.0.20010205133359.00aac3f0@192.168.0.18>
From: oyvind@datavakten.no (Øyvind Jægtnes)
Date: 05 Feb 2001 13:27:43 +0100
In-Reply-To: <4.3.2.7.0.20010205133359.00aac3f0@192.168.0.18>
Message-ID: <8766ipjow0.fsf@mordor.datavakten.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.1-pre3 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pat Verner <pat@isis.co.za> writes:

> I have Linux running on several older Pentium machines - Pentium -166
> MHz and Pentium - 120 Mhz.
> 
> Under kernel 2.2.13+ these machines report a BogoMips of 66 or 47
> respectively;  suddenly under kernel 2.4.[01] the speed is suddenly
> reported as 332 and 238 respectively.
> 
> Has there been a change in the definition of "BogoMips"?

AFAIK bogomips is just an internal delay calibration variable and not
something used to test the speed of the cpu, rather just how long a
certain loop takes to execute.


Øyvind Jægtnes

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
