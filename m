Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273176AbRJJB3l>; Tue, 9 Oct 2001 21:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273108AbRJJB3Y>; Tue, 9 Oct 2001 21:29:24 -0400
Received: from zok.sgi.com ([204.94.215.101]:5850 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S272773AbRJJB3I>;
	Tue, 9 Oct 2001 21:29:08 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: root@chaos.analogic.com
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Subject: Re: kernel size 
In-Reply-To: Your message of "Tue, 09 Oct 2001 11:53:48 -0400."
             <Pine.LNX.3.95.1011009114946.4152A-100000@chaos.analogic.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 11:29:31 +1000
Message-ID: <7568.1002677371@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 11:53:48 -0400 (EDT), 
"Richard B. Johnson" <root@chaos.analogic.com> wrote:
>Yes. It shows in /proc/kcore. Just wasted. It does mean something
>on an embedded system.

kcore shows all the kernel buffers, including user space stuff being
processed by the loader.  My tests show that all the strings that you
are complaining about have been stripped from the kernel before it is
loaded.

