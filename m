Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281383AbRKEWJ1>; Mon, 5 Nov 2001 17:09:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281382AbRKEWJR>; Mon, 5 Nov 2001 17:09:17 -0500
Received: from ns.suse.de ([213.95.15.193]:44305 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281381AbRKEWJH> convert rfc822-to-8bit;
	Mon, 5 Nov 2001 17:09:07 -0500
To: Tim Walberg <twalberg@mindspring.com>
Cc: Ville Herva <vherva@niksula.hut.fi>, John Adams <johna@onevista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Need blocking /dev/null
In-Reply-To: <Pine.LNX.4.21.0111012322310.14742-100000@Consulate.UFP.CX>
	<01110215041301.01066@flash> <20011102223209.D26218@niksula.cs.hut.fi>
	<20011102144604.E8312@mindspring.com>
X-Yow: If Robert Di Niro assassinates Walter Slezak, will
 Jodie Foster marry Bonzo??
From: Andreas Schwab <schwab@suse.de>
Date: 05 Nov 2001 23:08:57 +0100
In-Reply-To: <20011102144604.E8312@mindspring.com> (Tim Walberg's message of "Fri, 2 Nov 2001 14:46:04 -0600")
Message-ID: <jek7x4swee.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Walberg <twalberg@mindspring.com> writes:

|> I think that
|> 
|> find / -name foo 2>&-
|> 
|> should do the trick (under ksh, anyway, and
|> probably zsh or bash as well).

This is different since the process now gets an error when trying to write
to fd 2, and a good implementation with check for errors.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
