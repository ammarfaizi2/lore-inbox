Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbRAESUF>; Fri, 5 Jan 2001 13:20:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbRAESTz>; Fri, 5 Jan 2001 13:19:55 -0500
Received: from main.cornernet.com ([209.98.65.1]:62994 "EHLO
	main.cornernet.com") by vger.kernel.org with ESMTP
	id <S129387AbRAESTq>; Fri, 5 Jan 2001 13:19:46 -0500
Date: Fri, 5 Jan 2001 12:23:59 -0600 (CST)
From: Chad Schwartz <cwslist@main.cornernet.com>
To: kouqian <kouqian@etang.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: why getch() cann't work in rpm package's %post section?
In-Reply-To: <20010105100749.B183EBAB968@mta1.etang.com>
Message-ID: <Pine.LNX.4.30.0101051223260.30430-100000@main.cornernet.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is *NOT* a kernel question. Take this kind of stuff elsewhere.

The reason? RPM is NOT meant to take any input, on installation of a
package. if you're trying to do that, you're doing it the wrong way.

Chad


On Wed, 6 Dec 2000, kouqian wrote:

> a program using getch() function (included in curses.h) runs OK when it executes in
> system prompt.
> when I put it in rpm package's %post section, it can start running until getch()
> statement. press any key to test getch(), getch() has no response!
>
> Can anybody tell me how to resolve this problem?
> thanks very much.
>
>
> kouqian@etang.com
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
