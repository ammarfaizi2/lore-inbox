Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261665AbVEJPHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261665AbVEJPHa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 11:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEJPHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 11:07:30 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:40563 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261665AbVEJPHM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 11:07:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PAcAskkHTSK2ir2a4dTqOR48Rc6fe4eSkl48TWhlhMMdeDCoYzEwyT6lF/TfqeIm8G8ncqHSAkUy8p5lV5yDVfBW7hSul4/HsicWe/6Ww3tzs3vfqrxg+klehpCVNlDiZ8ixHOmKFCBQJmiD6UhrZxK6Ri1gMZ9ecIWef8zktvU=
Message-ID: <d120d50005051008072f316b50@mail.gmail.com>
Date: Tue, 10 May 2005 10:07:10 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mitch <Mitch@0bits.com>
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42806084.4010205@0Bits.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42806084.4010205@0Bits.COM>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Mitch <Mitch@0bits.com> wrote:
> Hi Dimitry,
> 
> No go with the patch, and even with patch and uncommenting the
> ps2_drain(). The alps touchpad is dead as a dodo.
> 

Ugh, yes, I see. Stupid cut-and-paste error.. Could you please try v7?
Again, p2_drain may need to be uncommented. If it still does not work
I need the debug data once more, please.

http://www.geocities.com/dt_or/input/2_6_11/psmouse-resync-2.6.11-v7.patch.gz

-- 
Dmitry
