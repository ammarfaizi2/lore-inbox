Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262686AbREOI4B>; Tue, 15 May 2001 04:56:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262687AbREOIzv>; Tue, 15 May 2001 04:55:51 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:26637 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262686AbREOIzk>;
	Tue, 15 May 2001 04:55:40 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.19 + VIA chipset + strange behaviour 
In-Reply-To: Your message of "Tue, 15 May 2001 18:04:35 +0930."
             <200105150834.SAA08720@mercury.physics.adelaide.edu.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 May 2001 18:55:32 +1000
Message-ID: <32518.989916932@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 May 2001 18:04:35 +0930 (CST), 
Jonathan Woithe <jwoithe@physics.adelaide.edu.au> wrote:
>ksymoops 2.4.1 on i686 2.2.19.  Options used
>Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry

module_list was added to the export list in 2.2.17 so the message above
implies that you are using kernel build information from 2.2.17 in your
2.2.19 build.  I suggest you follow http://www.tux.org/lkml/#s8-8 and
see if your problems recur after a completely clean kernel build.

