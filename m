Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266654AbUHSQ1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266654AbUHSQ1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266661AbUHSQ1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:27:23 -0400
Received: from ppp3-adsl-208.the.forthnet.gr ([193.92.234.208]:60457 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S266654AbUHSQ1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:27:19 -0400
From: V13 <v13@priest.com>
To: Patrick McFarland <diablod3@gmail.com>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 19 Aug 2004 19:22:21 +0300
User-Agent: KMail/1.7
Cc: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.enemy.org>,
       linux-kernel@vger.kernel.org, schilling@fokus.fraunhofer.de
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <d577e5690408190004368536e9@mail.gmail.com>
In-Reply-To: <d577e5690408190004368536e9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-7"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200408191922.22461.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 10:04, Patrick McFarland wrote:
> On Wed, 4 Aug 2004 14:33:09 +0200 (MET DST), H.Rosmanith (Kernel
>
> Mailing List) <kernel@wildsau.enemy.org> wrote:
> > Some stuff that started a flamewar.
>
> If no one has noticed yet, thanks to the additional license
> restrictions Joerg Schilling has added to cdrecord (due to this
> thread), it may be now moved to non-free in Debian in the near future.

I believe you're talking about those two comments:

/*
 * Begin restricted code for quality assurance.
 *
 * Warning: you are not allowed to modify or to remove the
 * Copyright and version printing code below!
 * See also GPL § 2 subclause c)
 *
 * If you modify cdrecord you need to include additional version
 * printing code that:
 *
 *      -       Clearly states that the current version is an
 *              inofficial (modified) version and thus may have bugs
 *              that are not present in the original.
 *
 *      -       Print your support e-mail address and tell people that
 *              you will do complete support for this version of
 *              cdrecord.
 *
 *              Or clearly state that there is absolutely no support
 *              for the modified version you did create.
 *
 *      -       Tell the users not to ask the original author for
 *              help.
 *
 * This limitation definitely also applies when you use any other
 * cdrecord release together with libscg-0.6 or later, or when you
 * use any amount of code from cdrecord-1.11a17 or later.
 * In fact, it applies to any version of cdrecord, see also
 * GPL Preamble, subsection 6.
 *
 * I am sorry for the inconvenience but I am forced to do this because
 * some people create inofficial branches. These branches create
 * problems but the initiators do not give support and thus cause the
 * development of the official cdrecord versions to slow down because
 * I am loaded with unneeded work.
 *
 * Please note that this is a memorandum on how I interpret the GPL.
 * If you use/modify/redistribute cdrecord, you need to accept it
 * this way.
 *
 *
 * The above statement is void if there has been neither a new version
 * of cdrecord nor a new version of star from the original author
 * within more then a year.
 */

open_cdrdefaults()
{
  /*
   * WARNING you are only allowed to change this filename if you also
   * change the documentation and add a statement that makes clear
   * where the official location of the file is why you did choose a
   * nonstandard location and that the nonstandard location only refers
   * to inofficial cdrecord versions.
   *
   * I was forced to add this because some people change cdrecord without
   * rational reason and then publish the result. As those people
   * don't contribute work and don't give support, they are causing extra
   * work for me and this way slow down the cdrecord development.
   */
   return (defltopen("/etc/default/cdrecord"));
}

I think he is partialy right, since noone should claim that the original 
author will support his modified versions. I don't know if this is compatible 
with GPL but, (if not) it can be rephrased sto that it will not limit 
redistribution or modifications of the program. 

Noone wants to provide support for modified versions of his programs (Lets say 
tainted kernels).

<<V13>>
