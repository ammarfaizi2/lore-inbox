Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281937AbRKUSXI>; Wed, 21 Nov 2001 13:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281476AbRKUSW5>; Wed, 21 Nov 2001 13:22:57 -0500
Received: from daikokuya.demon.co.uk ([158.152.184.26]:45837 "EHLO
	monkey.daikokuya.demon.co.uk") by vger.kernel.org with ESMTP
	id <S281395AbRKUSWq>; Wed, 21 Nov 2001 13:22:46 -0500
Date: Wed, 21 Nov 2001 18:23:23 +0000
To: Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Message-ID: <20011121182323.D13678@daikokuya.demon.co.uk>
In-Reply-To: <01112112401703.01961@nemo> <20011121133115.A1451@ragnar-hojland.com> <20011121144034.E2196@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011121144034.E2196@artax.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.23i
From: Neil Booth <neil@daikokuya.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec wrote:-

> AFAIK here the order *IS* defined. + operator is evaluated left to right
> unless operands are known not to have side-efects (in which case it doesn't
> matter). Functions are considered not having side-efects iff they are defined
> with constant atribute.

Nope, the order of evaluation of arithmetic operands is undefined, and is
often different depending upon the optimization setting.

Note that this is a totally separate issue to both precedence and
associativity.

Neil.
