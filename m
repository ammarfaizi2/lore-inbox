Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282888AbRK0JfN>; Tue, 27 Nov 2001 04:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRK0JfC>; Tue, 27 Nov 2001 04:35:02 -0500
Received: from weta.f00f.org ([203.167.249.89]:17561 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S282888AbRK0Jet>;
	Tue, 27 Nov 2001 04:34:49 -0500
Date: Tue, 27 Nov 2001 22:36:26 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
        Ben Greear <greearb@candelatech.com>, Ben Greear <greearb@agcs.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.16: 802.1Q VLAN non-modular
Message-ID: <20011127223626.A13821@weta.f00f.org>
In-Reply-To: <Pine.GSO.3.96.1011126165647.21598T-100000@delta.ds2.pg.gda.pl> <Pine.LNX.4.33L.0111261435090.1491-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111261435090.1491-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.23i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 02:35:55PM -0200, Rik van Riel wrote:

    OK, does anybody have good scripts for automatically compiling
    the kernel with many random configurations so we can discover
    bugs like this automagically ?

cd ~/wk/linux/focus/
while true ; do
  mconfig -m random
  make dep clean bzImage
[...]

sort of thing.

mconfig is super fast and simple, and seems to work very reliably.
I'm not sure why more people don't use it.



   --cw
