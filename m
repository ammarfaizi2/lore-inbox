Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286679AbSAGUXL>; Mon, 7 Jan 2002 15:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286708AbSAGUWw>; Mon, 7 Jan 2002 15:22:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:11526 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S286381AbSAGUWj>;
	Mon, 7 Jan 2002 15:22:39 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: pwd@mdtsoft.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update to the make rpm system kernel 2.4.17 and 2.5.1 
In-Reply-To: Your message of "Mon, 07 Jan 2002 13:07:10 CDT."
             <200201071807.g07I7AL08968@mdtsoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Jan 2002 07:22:27 +1100
Message-ID: <433.1010434947@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002 13:07:10 -0500 (EST), 
pwd@mdtsoft.com wrote:
>That said it looks like the best thing for me to do might be to move the "make rpm"
>function out of the Makefile and into a seperate script when kbuild 2.5 is 
>made live in the main line. The rpm build does not use the make system to
>build first phase and after that is under the control of RPM itself. 
>I assume that the xconfig, oldconfig, config and mconfig are present in
>kbuild 2.5?

Not mconfig, kbuild 2.4 contains the existing 2.4 CML1 targets plus the
new targets from CML2.

>What is the correct method to tell if 2.5 is live?

grep CONFIG_KBUILD_2_5=y .config

