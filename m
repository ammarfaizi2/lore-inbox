Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284776AbRLXLo1>; Mon, 24 Dec 2001 06:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284786AbRLXLoR>; Mon, 24 Dec 2001 06:44:17 -0500
Received: from hal.grips.com ([62.144.214.40]:65001 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S284776AbRLXLoN>;
	Mon, 24 Dec 2001 06:44:13 -0500
Message-Id: <200112241144.fBOBi9t28424@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
        linux-aio <linux-aio@kvack.org>
Subject: Re: aio
Date: Mon, 24 Dec 2001 12:44:09 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0112201354420.1545-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0112201354420.1545-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sigtimedwait and sigwaitinfo in combination with SIGIO prevents the 
asynchronous event problem and works very well for me.

Gerold

On Thursday 20 December 2001 22:59, Linus Torvalds wrote:
> It's much easier to have a synchronous interface to the asynchronous IO,
> ie one where you do not have to worry about events happening "at the same
> time".
>
