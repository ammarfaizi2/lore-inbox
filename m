Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276611AbRJBSzV>; Tue, 2 Oct 2001 14:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276573AbRJBSzK>; Tue, 2 Oct 2001 14:55:10 -0400
Received: from weta.f00f.org ([203.167.249.89]:20886 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S276548AbRJBSzB>;
	Tue, 2 Oct 2001 14:55:01 -0400
Date: Wed, 3 Oct 2001 06:56:11 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Ricky Beam <jfbeam@bluetopia.net>
Cc: Andrew Morton <akpm@zip.com.au>,
        Lorenzo Allegrucci <lenstra@tiscalinet.it>,
        linux-kernel@vger.kernel.org
Subject: Re: Huge console switching lags
Message-ID: <20011003065611.B28891@weta.f00f.org>
In-Reply-To: <3BB9F1F2.B6873DFD@zip.com.au> <Pine.GSO.4.33.0110021408310.22872-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0110021408310.22872-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 02:10:41PM -0400, Ricky Beam wrote:

    And what's the brilliant reason for this?  And don't give any BS
    about it taking too long inside an interrupt context -- we're
    switching consoles not start netscrape.

Having console switching in interrupt context was horrible... I would
much rather have the 'odd' slightly delayed console switch than drop
stuff or have sound jitter every time I switch console (which sucks
badly).

Under even fairly heavy load here it's not a problem, what problems
does the new bahaviour create (sorry, a fork bomb is a silly
example).  With a load-average of over 20 its still responsive.





  --cw
