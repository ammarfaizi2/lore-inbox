Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129239AbRBCGWq>; Sat, 3 Feb 2001 01:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129285AbRBCGWg>; Sat, 3 Feb 2001 01:22:36 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:19465 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129239AbRBCGWa>;
	Sat, 3 Feb 2001 01:22:30 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Martin Bogomolni <andovernet@earthlink.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Missing modversions.h in module sources for 2.4.x? 
In-Reply-To: Your message of "Fri, 02 Feb 2001 21:28:13 -0800."
             <3A7B96ED.7030901@earthlink.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Feb 2001 17:22:24 +1100
Message-ID: <13199.981181344@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Feb 2001 21:28:13 -0800, 
Martin Bogomolni <andovernet@earthlink.net> wrote:
>c02817f0 usb_match_id_R__ver_usb_match_id
>The solution was to add the #include <linux/modversions.h> header
>into each of the drivers affected.

Wrong.  See http://www.tux.org/lkml/#s8-8

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
