Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277933AbRJRScL>; Thu, 18 Oct 2001 14:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277924AbRJRScC>; Thu, 18 Oct 2001 14:32:02 -0400
Received: from www.transvirtual.com ([206.14.214.140]:36109 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S277933AbRJRSbl>; Thu, 18 Oct 2001 14:31:41 -0400
Date: Thu, 18 Oct 2001 11:32:08 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Chip Salzenberg <chip@pobox.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxconsole-dev@lists.sourceforge.net
Subject: Re: [PATCH] input-ps2: sprintf() params missing
In-Reply-To: <20011017202343.A5079@perlsupport.com>
Message-ID: <Pine.LNX.4.10.10110181131210.32143-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The recently advertised input-ps2 patch has a minor repeated bug, in
> that sprintf() calls are made without enough parameters.  I'm not sure
> what the right fix is, but the attached patch at least calls sprintf()
> correctly.

Oops. It was a quick fix to deal with the extra field we have in struct
serio whcih is not in the standard kernel. Thank you for the fix. 

