Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267356AbTBPTuk>; Sun, 16 Feb 2003 14:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTBPTuk>; Sun, 16 Feb 2003 14:50:40 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:27142 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S267356AbTBPTuj>;
	Sun, 16 Feb 2003 14:50:39 -0500
Date: Sun, 16 Feb 2003 21:00:36 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Alvaro Barbosa G." <alvaro.barbosa-g@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: > > make: *** No rule to make target `2'.  Stop. when make bzImage
Message-ID: <20030216200036.GA26590@mars.ravnborg.org>
Mail-Followup-To: "Alvaro Barbosa G." <alvaro.barbosa-g@ntlworld.com>,
	linux-kernel@vger.kernel.org
References: <200302161939.21889.alvaro.barbosa-g@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302161939.21889.alvaro.barbosa-g@ntlworld.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2003 at 07:39:21PM +0000, Alvaro Barbosa G. wrote:
> Sorry for the lack of info:
> 
> Errors happen during: 
> make bzImage 
> will add the error file bzI_err
> the architecture is for i686
> this happen also with phoebe kernel-2.4.20-2.48, i had this problem a few
> days ago, so i upgraded gcc, cpp, glibc, rpm to the latest rawhide rpms 
> 15.2.03, but get the same error 'make No rule to make target '2''

You did not provide the exact command you are using..
The attached log of the output looks OK. And I did not find the
offending error.

I suspect that the syntax you use to divert output to a file is wrong,
because the above error happens when you execute:
make 2

Try to doublecheck how you invoke make, and check any relevant environment
variables.

	Sam
