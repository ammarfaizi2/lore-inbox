Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317280AbSFCFoi>; Mon, 3 Jun 2002 01:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317281AbSFCFoh>; Mon, 3 Jun 2002 01:44:37 -0400
Received: from rj.SGI.COM ([192.82.208.96]:64731 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S317280AbSFCFoh>;
	Mon, 3 Jun 2002 01:44:37 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: Decoding of addreses in kernel logs 
In-Reply-To: Your message of "Mon, 03 Jun 2002 09:39:41 +0400."
             <6134254DE87BD411908B00A0C99B044F02E89B5A@mowd019a.mow.siemens.ru> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Jun 2002 15:44:30 +1000
Message-ID: <31248.1023083070@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Jun 2002 09:39:41 +0400, 
Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru> wrote:
>Thank you. My only concern is that klogd decodes addresses in real time
>(if it is able to do it at all) while ksymoops is usually postmortem. It
>means that ksymoops may not have access to real module addresses? 

klogd rarely has access to module addresses either.  klogd loads its
module list at startup, not when modules are loaded or unloaded.  There
is support in both insmod and ksymoops for module decoding, man insmod
and look for ksymoops assistance.

