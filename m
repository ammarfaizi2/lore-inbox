Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSDIOab>; Tue, 9 Apr 2002 10:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291401AbSDIOaa>; Tue, 9 Apr 2002 10:30:30 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:18960 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S290818AbSDIOa2>; Tue, 9 Apr 2002 10:30:28 -0400
Date: Tue, 9 Apr 2002 11:30:09 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        "T. A." <tkhoadfdsaf@hotmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: C++ and the kernel
In-Reply-To: <Pine.LNX.3.95.1020409085537.4291B-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.44L.0204091128370.31387-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Richard B. Johnson wrote:
> On Tue, 9 Apr 2002, Dr. David Alan Gilbert wrote:

> > There are many places in the kernel that are actually very OO - look at
> > filesystems for example. The super_operations sturcture is in effect a
> > virtual function table.
>
> The file operations structure(s) are structures. They are not object-
> oriented in any way, and they are certainly not virtual. The code that
> manipulates them is quite physical and procedural, well defined, and
> visible to the rest of the kernel.

As Alan said it very nicely one day:

	"Object orientation is in the mind, not in the compiler"


What we want is some (sane) degree of abstraction so things stay
maintainable, we don't need a full rewrite in another language.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

