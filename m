Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311347AbSCLVfY>; Tue, 12 Mar 2002 16:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311350AbSCLVfE>; Tue, 12 Mar 2002 16:35:04 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:34831 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S311347AbSCLVex>;
	Tue, 12 Mar 2002 16:34:53 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: mcp@linux-systeme.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: make xconfig question 
In-Reply-To: Your message of "Tue, 12 Mar 2002 22:02:14 BST."
             <Pine.LNX.4.43.0203122200420.25997-100000@codeman.linux-systeme.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Mar 2002 08:34:38 +1100
Message-ID: <13774.1015968878@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Mar 2002 22:02:14 +0100 (CET), 
mcp@linux-systeme.de wrote:
>./tkparse < ../arch/i386/config.in >> kconfig.tk
>statement not in menu
>make[1]: *** [kconfig.tk] Error 1
>make[1]: Leaving directory `/usr/src/linux-2.4.18-mcp3-WOLK/scripts'
>make: *** [xconfig] Error 2

Probably an extra unmatched 'endmenu' statement.

