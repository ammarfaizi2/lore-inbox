Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293635AbSCKIIp>; Mon, 11 Mar 2002 03:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293637AbSCKIIe>; Mon, 11 Mar 2002 03:08:34 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:64264 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S293635AbSCKIIV>;
	Mon, 11 Mar 2002 03:08:21 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: linux390@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Patch to fix s390 cross-compilation in 2.4.18 
In-Reply-To: Your message of "Mon, 11 Mar 2002 02:25:29 CDT."
             <20020311022529.A29248@devserv.devel.redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Mar 2002 19:08:06 +1100
Message-ID: <28920.1015834086@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002 02:25:29 -0500, 
Pete Zaitcev <zaitcev@redhat.com> wrote:
>The s390 cannot be cross-compiled, because necessary -I is missing
>from gcc flags of assembler modules. Also I straightened flags up
>a little bit (removed duplicated -D__ASSEMBLY__).

Looks good.  Could you try without -traditional?  I want to know if
that flag is really required or not.

