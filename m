Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261339AbSLJM16>; Tue, 10 Dec 2002 07:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261368AbSLJM16>; Tue, 10 Dec 2002 07:27:58 -0500
Received: from cm19173.red.mundo-r.com ([213.60.19.173]:14267 "EHLO
	demo.mitica") by vger.kernel.org with ESMTP id <S261339AbSLJM15>;
	Tue, 10 Dec 2002 07:27:57 -0500
To: Daniel Egger <degger@fhm.edu>
Cc: Dave Jones <davej@codemonkey.org.uk>, Joseph <jospehchan@yahoo.com.tw>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
	<20021210055215.GA9124@suse.de> <1039504941.30881.10.camel@sonja>
X-Url: http://people.mandrakesoft.com/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <1039504941.30881.10.camel@sonja>
Date: 10 Dec 2002 13:40:56 +0100
Message-ID: <m27kei9hd3.fsf@demo.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2.92
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "daniel" == Daniel Egger <degger@fhm.edu> writes:

daniel> Am Die, 2002-12-10 um 06.52 schrieb Dave Jones:
>> I believe someone (Jeff Garzik?) benchmarked gcc code generation,
>> and the C3 executed code scheduled for a 486 faster than it did for
>> -m586
>> I'm not sure about the alignment flags. I've been meaning to look
>> into that myself...

daniel> Interesting. I have no clue about which C3 you're talking about here but
daniel> a VIA Ezra has all 686 instructions including cmov and thus optimising 
daniel> for PPro works best for me.

Have you tested it?

Here, we got cmov to work if the two operands are registers, if any of
the operands is in memory, it don't work.

Been there, been burned :p 

Later, Juan.

-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
