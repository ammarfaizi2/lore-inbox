Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130849AbQKTDWE>; Sun, 19 Nov 2000 22:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbQKTDVy>; Sun, 19 Nov 2000 22:21:54 -0500
Received: from lin-hs4-025.inetnebr.com ([209.50.4.121]:60918 "EHLO
	falcon.inetnebr.com") by vger.kernel.org with ESMTP
	id <S130849AbQKTDVs>; Sun, 19 Nov 2000 22:21:48 -0500
Date: Sun, 19 Nov 2000 20:51:11 -0600
From: Jeff Epler <jepler@inetnebr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: run level 1, login takes too long, 2.4.X vs. 2.2.X
Message-ID: <20001119205111.A2828@potty.housenet>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A18573B.E65CA88A@megsinet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <3A18573B.E65CA88A@megsinet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2000 at 04:42:03PM -0600, M.H.VanLeeuwen wrote:
> I had occasion to "telinit 1" today and found that it took a long time
> to login after root passwd was entered.  this doesn't happen with 2.2.X
> kernels.
> 
> Is this to be expected with the 2.4 series kernels? or a bug?

It looks like login is trying to contact a YP server but getting no
response.  Was the kernel the only configuration detail you modified?

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
