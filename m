Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130339AbRAWMUB>; Tue, 23 Jan 2001 07:20:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130372AbRAWMTv>; Tue, 23 Jan 2001 07:19:51 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:58385 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S130339AbRAWMTp>;
	Tue, 23 Jan 2001 07:19:45 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Anders Karlsson <anders.karlsson@meansolutions.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-ac10 compile errors 
In-Reply-To: Your message of "Tue, 23 Jan 2001 12:16:11 -0000."
             <20010123121611.A3723@alien.ssd.hursley.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jan 2001 23:19:38 +1100
Message-ID: <23997.980252378@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001 12:16:11 +0000, 
Anders Karlsson <anders.karlsson@meansolutions.com> wrote:
>Even if it is a pristine kernel tree? What function does the 'make
>mrproper' fill on an unused kernel tree?

Depends on how you removed the old tree.  If you did 'rm -rf *' then
some dot files are left around.  make mrproper removes dot files, it
may or may not be the fix.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
