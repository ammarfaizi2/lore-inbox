Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290504AbSAQWdE>; Thu, 17 Jan 2002 17:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290506AbSAQWcz>; Thu, 17 Jan 2002 17:32:55 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:57607 "EHLO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S290504AbSAQWcg>; Thu, 17 Jan 2002 17:32:36 -0500
Date: Thu, 17 Jan 2002 23:32:32 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: newbie with a qlogic host bus adapter
Message-ID: <20020117223232.GA26240@emma1.emma.line.org>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C474B9C.560DF747@excelco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <3C474B9C.560DF747@excelco.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jan 2002, root wrote:

> I have a Qlogic qla2200f host bus adapter for an optical SAN.  I am
> running SuSE linux 7.1, I just downloaded kernel 2.4.17 sources and want
> to compile a kernel.  But when I "make menuconfig" 
> I go into scsi support, and into scs low level drivers, the qlogic
> "qla2x00 QLC driver support" is not an option as it should be according
> to the documentation for the qla2200.
> how do i fix that?
> 
> also i tried to just compile the drivers to be modules, but i get the
> error: /usr/src/linux-2.4/include/linux/modversions.h: No such file or
> directory
> 
> where can I get this file?

You can probably just do
cd /usr/src
ln -s linux-2.4.WHATEVERSUSE7.1HAS linux-2.4

to "fix" the latter problem, or maybe you need to tweak the Makefile.

As to the former problem, I cannot tell. Should your problem not be
solved until Jan 27th, feel free to ask me in private mail.

Oh, and while I'm at it: please do use a regular user account to read
and send mail, root should not expose himself to the dangers of possible
bugs in his mailer -- use yast or useradd to add a regular user for
yourself, and use /etc/aliases or /etc/mail/aliases to forward root mail
to that user.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
