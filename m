Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130873AbRC3GzU>; Fri, 30 Mar 2001 01:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130900AbRC3GzL>; Fri, 30 Mar 2001 01:55:11 -0500
Received: from agnus.shiny.it ([194.20.232.6]:58641 "EHLO agnus.shiny.it")
	by vger.kernel.org with ESMTP id <S130873AbRC3Gy7>;
	Fri, 30 Mar 2001 01:54:59 -0500
Message-ID: <XFMail.010330085217.pochini@shiny.it>
X-Mailer: XFMail 1.3 [p0] on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3AC3A6C9.991472C0@chromium.com>
Date: Fri, 30 Mar 2001 08:52:17 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Fabio Riccardi <fabio@chromium.com>
Subject: RE: linux scheduler limitations?
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 29-Mar-01 Fabio Riccardi wrote:
> Hello,
> 
> I'm working on an enhanced version of Apache and I'm hitting my head
> against something I don't understand.
> 
> I've found a (to me) unexplicable system behaviour when the number of
> Apache forked instances goes somewhere beyond 1050, the machine
> suddently slows down almost top a halt and becomes totally unresponsive,
> until I stop the test (SpecWeb).

Are you using 2.2.x ?  I had the same problem here until I switched
to 2.4.x. 2.2 internal locks are not fine grained enough.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-

