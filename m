Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316771AbSE0WFw>; Mon, 27 May 2002 18:05:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316770AbSE0WFw>; Mon, 27 May 2002 18:05:52 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:34290 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316769AbSE0WFv>; Mon, 27 May 2002 18:05:51 -0400
Subject: Re: Memory management in Kernel 2.4.x
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020527215632.GR14918@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 28 May 2002 00:07:57 +0100
Message-Id: <1022540877.4123.7.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-05-27 at 22:56, William Lee Irwin III wrote:
> If you're willing to take a feature request, I'd be much obliged if the
> pagetable memory were also accounted.

I suspect that is doable providing you are willing to handwave a few
assumptions and be a fraction conservative. However I'm accounting
against ram+swap. You need to account against ram only.

