Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269472AbRHGVau>; Tue, 7 Aug 2001 17:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269473AbRHGVak>; Tue, 7 Aug 2001 17:30:40 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:1980
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S269472AbRHGVae>; Tue, 7 Aug 2001 17:30:34 -0400
Date: Tue, 7 Aug 2001 14:30:41 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: <kakadu@adelphia.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Strange compilation messages with gcc 2.96.2
In-Reply-To: <3B704C86.5010401@earthlink.net>
Message-ID: <Pine.LNX.4.33.0108071424270.17919-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Brad Chapman wrote:

>    <source file>:<number>:<number>: pasting would not give a valid
> preprocessor token

It means the compiler ran into something like:

#define foo(a) do { a ## 2 ## .something() } while(0)

which should be

... a ## 2 .something() ...


justin

