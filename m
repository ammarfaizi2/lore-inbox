Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWBSHlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWBSHlm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 02:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWBSHlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 02:41:42 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:1562 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932144AbWBSHll convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 02:41:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZcytyEZS9BYcQuGjR3iWHBxV72XJgWSifo5TG4RSPCBG1dKylplUYNU9LtkPNlw33WPxIZKCVpUv29lirN5n/jqkD01mby2idNTuUaDhHi1issqZWKBG2Lro9aKpOWtWzZzpl3fB+pHM1DR5tcfznU7+56/wTYUNWwy1aNzxeyY=
Message-ID: <5a2cf1f60602182341i50098d4av365a8caf96b272df@mail.gmail.com>
Date: Sun, 19 Feb 2006 08:41:41 +0100
From: "jerome lacoste" <jerome.lacoste@gmail.com>
To: "Brian Hall" <brihall@pcisys.net>
Subject: Re: Help: DGE-560T not recognized by Linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060218195512.6bed967b.brihall@pcisys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060217222720.a08a2bc1.brihall@pcisys.net>
	 <20060217222428.3cf33f25.akpm@osdl.org>
	 <20060218003622.30a2b501.brihall@pcisys.net>
	 <20060217234841.5f2030ec.akpm@osdl.org>
	 <20060218195512.6bed967b.brihall@pcisys.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/19/06, Brian Hall <brihall@pcisys.net> wrote:
> For the benefit of anyone searching later:
>
> The problem was the current linux Marvell drivers (2.6.15/16rc4) not
> detecting my Dlink card. After trying and failing to compile with the
> linux driver (2.6.13-based) supplied on the retail CD (suprised, didn't
> even think to look there at first!), I went to the Marvell site
> directly and downloaded their version of the sk98lin driver, which
> comes with a script to create a patch against whatever your current
> linux version is in /usr/src/linux. That was found at:
>
> http://www.marvell.com/drivers/driverDisplay.do?dId=107&pId=10

Interesting. First time I see a vendor distribute a GPL kernel source
patch. It could be interesting to diff this with what is in the
current kernel.

J
