Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311919AbSC2LAY>; Fri, 29 Mar 2002 06:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313434AbSC2LAP>; Fri, 29 Mar 2002 06:00:15 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:56845 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311919AbSC2LAA>;
	Fri, 29 Mar 2002 06:00:00 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "Amit S. Kale" <kgdb@vsnl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: announce: kgdb 1.5 with reworked buggy smp handling 
In-Reply-To: Your message of "Fri, 29 Mar 2002 16:01:36 +0530."
             <3CA44288.EF27E043@vsnl.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 29 Mar 2002 21:59:50 +1100
Message-ID: <30144.1017399590@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 16:01:36 +0530, 
"Amit S. Kale" <kgdb@vsnl.net> wrote:
>kgdb 1.5 at http://kgdb.sourceforge.net/
>
>smp handling is completely reworked. Previous kgdb had a bug
>which caused it to hang when a processor spun with
>interrupts disabled and another processor enters kgdb. kgdb
>now uses nmi watchdog for holding other processors while
>a machine is in kgdb. 

IA64 disabled spin loops ignore NMI :(.

