Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272546AbRI0MVG>; Thu, 27 Sep 2001 08:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272552AbRI0MU4>; Thu, 27 Sep 2001 08:20:56 -0400
Received: from atbode61.informatik.tu-muenchen.de ([131.159.32.54]:49536 "EHLO
	atbode61.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id <S272546AbRI0MUq>; Thu, 27 Sep 2001 08:20:46 -0400
Date: Thu, 27 Sep 2001 14:20:06 +0200
From: Georg Acher <acher@in.tum.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Nemosoft Unv." <nemosoft@smcc.demon.nl>, Jan Harkes <jaharkes@cs.cmu.edu>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
        webcam@smcc.demon.nl, "Eloy A.Paris" <eloy.paris@usa.net>,
        linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] RE: [PATCH -R] Re: 2.4.10 is toxic to my system when I use my US
Message-ID: <20010927142006.B1491@atbode61.informatik.tu-muenchen.de>
Mail-Followup-To: Georg Acher <acher@in.tum.de>,
	Ingo Molnar <mingo@elte.hu>,
	"Nemosoft Unv." <nemosoft@smcc.demon.nl>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org, webcam@smcc.demon.nl,
	"Eloy A.Paris" <eloy.paris@usa.net>,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <XFMail.010927083327.nemosoft@smcc.demon.nl> <Pine.LNX.4.33.0109271057030.3716-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.33.0109271057030.3716-100000@localhost.localdomain>; from mingo@elte.hu on Thu, Sep 27, 2001 at 11:00:24AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2001 at 11:00:24AM +0200, Ingo Molnar wrote:
 
> yep. this is one reason why the 2.4.10 kernel clears the ->next and ->prev
> pointers in list_del() - the above code will break immediately.

Good intention, very bad timing. All of these bug-provoking fixes for a
production kernel should only occur in the first kernels of a -pre-series,
not in the last one.

-- 
         Georg Acher, acher@in.tum.de         
         http://www.in.tum.de/~acher/
          "Oh no, not again !" The bowl of petunias          
