Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290397AbSAPKuU>; Wed, 16 Jan 2002 05:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290407AbSAPKuL>; Wed, 16 Jan 2002 05:50:11 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:48137 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S290397AbSAPKt6>;
	Wed, 16 Jan 2002 05:49:58 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution) 
In-Reply-To: Your message of "Tue, 15 Jan 2002 16:22:52 PDT."
             <20020115232252.GC5220@cpe-24-221-152-185.az.sprintbbd.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 Jan 2002 21:49:43 +1100
Message-ID: <21015.1011178183@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 16:22:52 -0700, 
Tom Rini <trini@kernel.crashing.org> wrote:
>... and last I looked at kbuild-2.5, it asked if
>you wanted to stick your .config in /lib/modules/`uname -r` (which is
>default loc for System.map too..)  Or maybe it just did it.

The first time you make oldconfig kbuild 2.5 asks if you want to
install System.map and .config, separate questions.  If you say y then
it asks where you want to install the files, with a default of
/lib/modules/`uname -r`/.  Once set, the values propagate to subsequent
builds that use the same .config.

