Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290144AbSAKWTZ>; Fri, 11 Jan 2002 17:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290143AbSAKWTF>; Fri, 11 Jan 2002 17:19:05 -0500
Received: from are.twiddle.net ([64.81.246.98]:45702 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S290140AbSAKWTA>;
	Fri, 11 Jan 2002 17:19:00 -0500
Date: Fri, 11 Jan 2002 14:18:50 -0800
From: Richard Henderson <rth@twiddle.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Q] Looking for an emulation for CMOV* instructions.
Message-ID: <20020111141850.A9873@twiddle.net>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Ronald Wahl <Ronald.Wahl@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <m2sn9dn2kh.fsf@goliath.csn.tu-chemnitz.de> <E16Opxl-00066O-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16Opxl-00066O-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Jan 11, 2002 at 12:54:29AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2002 at 12:54:29AM +0000, Alan Cox wrote:
> It means the compiler for -m686 shouldn't have assumed cmov was available

Eh?  -march=i686 *asserts* that cmov is available.

What's the point of optimizing an IF to a cmov if I have
to insert another IF to see if I can use cmov?


r~
