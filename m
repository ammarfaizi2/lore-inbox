Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269411AbRHGUR7>; Tue, 7 Aug 2001 16:17:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHGURt>; Tue, 7 Aug 2001 16:17:49 -0400
Received: from ntt-connection.daiwausa.com ([210.175.188.3]:9053 "EHLO
	ead42.ead.dsa.com") by vger.kernel.org with ESMTP
	id <S269411AbRHGURh>; Tue, 7 Aug 2001 16:17:37 -0400
Date: Tue, 7 Aug 2001 16:17:23 -0400
From: "Bill Rugolsky Jr." <rugolsky@ead.dsa.com>
To: Justin Guyett <justin@soze.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: encrypted swap
Message-ID: <20010807161723.A14270@ead45>
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C9A8@mail0.myrio.com> <Pine.LNX.4.33.0108071223100.17919-100000@kobayashi.soze.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.33.0108071223100.17919-100000@kobayashi.soze.net>; from justin@soze.net on Tue, Aug 07, 2001 at 12:48:34PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 07, 2001 at 12:48:34PM -0700, Justin Guyett wrote:
> As someone just pointed out, if the laptop's suspended, the password for
> encrypted swap pretty much has to be in ram, unless you're going to add
> hooks in resume such that before anything even starts running again
> (possible?) it prompts for the decryption password.  Otherwise, you can't
> block swap access, and if the data's encrypted, seems like that will crash
> the machine.

Well, one can suspend the machine with swsusp, and supply a passphrase
as a kernel boot option.  It is essential to overwrite all copies of that string,
of course. :-)

Regards,

  Bill Rugolsky
