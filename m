Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265259AbSJWWeO>; Wed, 23 Oct 2002 18:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265276AbSJWWeO>; Wed, 23 Oct 2002 18:34:14 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:34692 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265259AbSJWWeN> convert rfc822-to-8bit;
	Wed, 23 Oct 2002 18:34:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: James Stevenson <james@stev.org>
Subject: Re: One for the Security Guru's
Date: Wed, 23 Oct 2002 15:39:43 -0700
User-Agent: KMail/1.4.1
Cc: Gilad Ben-ossef <gilad@benyossef.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20021023130251.GF25422@rdlg.net> <200210231514.07192.jamesclv@us.ibm.com> <1035411422.5377.11.camel@god.stev.org>
In-Reply-To: <1035411422.5377.11.camel@god.stev.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210231539.43167.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 October 2002 03:17 pm, James Stevenson wrote:
> > Be surprised:  I run "gpg --verify foo.tgz.sign foo.tgz" every time I
> > download from kernel.org.  And, "rpm --checksig *.rpm" on stuff from
> > redhat.com too.
>
> and when an attacker looks into your .bash_history see this and modifies
> gpg and rpm ?

First, I use ksh, so the kiddie is looking into the wrong history.   ;^)

Second, I'm trying to keep him/her/git out by not loading a trojaned package.  
Once the scumbag is inside your box, it's much harder to throw them out.  In 
fact, a reinstall is usually in order.

Third, if they don't do it already, I'd like kpackage, gnorpm, and similar 
tools to always check signatures before loading a package.  (And, for the GPG 
public keys used to have come with trust signatures from the installation 
CD.)  That would really help with all the newbies to *nix coming on board 
now.

PS:  If you don't trust your gpg or rpm, boot off install CD # 1, switch to a 
text console, and use the ones on the CD.  QED.    :^)

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

