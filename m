Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281410AbRKZCLH>; Sun, 25 Nov 2001 21:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281404AbRKZCK5>; Sun, 25 Nov 2001 21:10:57 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:47113 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S281395AbRKZCKw>;
	Sun, 25 Nov 2001 21:10:52 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marcin Glogowski <marcingl@poczta.onet.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modules.conf aliases 
In-Reply-To: Your message of "Mon, 26 Nov 2001 01:24:50 BST."
             <Pine.LNX.4.33.0111260106040.2697-100000@opium.domek> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Nov 2001 13:10:40 +1100
Message-ID: <1494.1006740640@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 01:24:50 +0100 (CET), 
Marcin Glogowski <marcingl@poczta.onet.pl> wrote:
>Does anybody know where can I find the STANDARD kernel aliases that
>are send by kernel to modprobe, when the kernel can't find properly
>piece of code himself?

You can grep the kernel source for calls to request_module() and see
what string is built.  If you are just trying to diagnose a problem,
create directory /var/log/ksymoops (man insmod for details) and
modprobe will create a log entry whenever it is called.

