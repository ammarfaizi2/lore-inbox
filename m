Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290517AbSAQXQQ>; Thu, 17 Jan 2002 18:16:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290515AbSAQXQH>; Thu, 17 Jan 2002 18:16:07 -0500
Received: from svr3.applink.net ([206.50.88.3]:31246 "EHLO svr3.applink.net")
	by vger.kernel.org with ESMTP id <S289949AbSAQXQC>;
	Thu, 17 Jan 2002 18:16:02 -0500
Message-Id: <200201172313.g0HNDlk02939@home.ashavan.org.>
Content-Type: text/plain; charset=US-ASCII
From: Timothy Covell <timothy.covell@ashavan.org>
Reply-To: timothy.covell@ashavan.org
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: newbie with a qlogic host bus adapter
Date: Thu, 17 Jan 2002 17:11:29 -0600
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C474B9C.560DF747@excelco.com> <20020117223232.GA26240@emma1.emma.line.org>
In-Reply-To: <20020117223232.GA26240@emma1.emma.line.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 January 2002 16:32, Matthias Andree wrote:
> On Thu, 17 Jan 2002, root wrote:
> > I have a Qlogic qla2200f host bus adapter for an optical SAN.  I am
> > running SuSE linux 7.1, I just downloaded kernel 2.4.17 sources and want
> > to compile a kernel.  But when I "make menuconfig"
> > I go into scsi support, and into scs low level drivers, the qlogic
> > "qla2x00 QLC driver support" is not an option as it should be according
> > to the documentation for the qla2200.
> > how do i fix that?
> >
> > also i tried to just compile the drivers to be modules, but i get the
> > error: /usr/src/linux-2.4/include/linux/modversions.h: No such file or
> > directory
> >
> > where can I get this file?
>
> You can probably just do
> cd /usr/src
> ln -s linux-2.4.WHATEVERSUSE7.1HAS linux-2.4
>
> to "fix" the latter problem, or maybe you need to tweak the Makefile.
>
> As to the former problem, I cannot tell. Should your problem not be
> solved until Jan 27th, feel free to ask me in private mail.
>
> Oh, and while I'm at it: please do use a regular user account to read
> and send mail, root should not expose himself to the dangers of possible
> bugs in his mailer -- use yast or useradd to add a regular user for
> yourself, and use /etc/aliases or /etc/mail/aliases to forward root mail
> to that user.


I you would like more good SysAdmin advice, please let your employer
know that I am available.  I've been doing Linux/Unix SysAdmin for
over five years now.   My resume is available upon request.

-- 
timothy.covell@ashavan.org.
