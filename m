Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289817AbSAQQjM>; Thu, 17 Jan 2002 11:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289867AbSAQQjC>; Thu, 17 Jan 2002 11:39:02 -0500
Received: from trained-monkey.org ([209.217.122.11]:32525 "EHLO
	trained-monkey.org") by vger.kernel.org with ESMTP
	id <S289817AbSAQQiu>; Thu, 17 Jan 2002 11:38:50 -0500
From: Jes Sorensen <jes@wildopensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15430.65012.734810.776663@trained-monkey.org>
Date: Thu, 17 Jan 2002 11:38:12 -0500
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [patch] VAIO irq assignment fix
In-Reply-To: <Pine.LNX.4.33.0201171620510.19753-100000@chaos.tp1.ruhr-uni-bochum.de>
In-Reply-To: <15430.60214.968250.153045@trained-monkey.org>
	<Pine.LNX.4.33.0201171620510.19753-100000@chaos.tp1.ruhr-uni-bochum.de>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kai" == Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de> writes:

Kai> On Thu, 17 Jan 2002, Jes Sorensen wrote:
>> I think it's in the ACPI table since a certain M$ OS finds the
>> interrupt source. As I mentioned to Alan, I tried the latest ACPI
>> patch but as you say, nothing is done with the information. I haven't
>> tried enabling ACPI_DEBUG but that sounds to be a next step.

Kai> ACPI_DEBUG should print the table at least :)

Kai> My patch is appended, it applies on top of 2.4.17+acpi-20011218

Tried it and I can report your patch works as well. I guess I'll need to
modify my patch to not mangle things if your patch is installed, or at
least we should keep my patch in place until the latest ACPI gets
integrated.

Cheers,
Jes
