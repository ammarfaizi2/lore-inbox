Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290222AbSAWXyO>; Wed, 23 Jan 2002 18:54:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290220AbSAWXyC>; Wed, 23 Jan 2002 18:54:02 -0500
Received: from fungus.teststation.com ([212.32.186.211]:36359 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S290221AbSAWXxO>; Wed, 23 Jan 2002 18:53:14 -0500
Date: Thu, 24 Jan 2002 00:53:01 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.teststation.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Andrew Morton <akpm@zip.com.au>, Martin Eriksson <nitrax@giron.wox.org>,
        Justin A <justin@bouncybouncy.net>, Andy Carlson <naclos@swbell.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: via-rhine timeouts
In-Reply-To: <200201232325.AAA12824@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.33.0201240040311.3190-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002, Stephan von Krawczynski wrote:

> Forgive me being stupid, but shouldn't the comment behind follow      
> somehow?                                                              
> I may be dead wrong, but you're increasing the initial treshold here, 
> or not?                                                               
> Please ignore me if I am way off.                                     

The hardware doesn't care about the comment in the source code. :)

Anyway, 32bytes is incorrect for the vt6102. According to the vt6102
docs 0x20 is 256 bytes and 0x80 is "store&forward".

Test it, if it helps the comment can be changed to something that is 
correct (like /* Initial threshold */ ?)

/Urban

