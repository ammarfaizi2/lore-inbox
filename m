Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266945AbTGGMM7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266953AbTGGMM7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:12:59 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14761
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266945AbTGGMM6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:12:58 -0400
Subject: Re: C99 types VS Linus types
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: matthias.andree@gmx.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1057579305.747.79.camel@cube>
References: <1057579305.747.79.camel@cube>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057580683.2748.17.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jul 2003 13:24:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-07 at 13:01, Albert Cahalan wrote:
> The days of non-power-of-two word sizes are
> gone for normal computing. Sign-magnitude and
> ones-compliment are dead too. Float is IEEE
> format, possibly skipping a few costly features.
> Nobody is going to go back to the old way.
> 
> It's too bad the C99 committee didn't have the
> guts to make this official.

The C99 people have to handle non-normal computing too. C
has lots of little quirks (like pointers off the end of
array rules) from this.

