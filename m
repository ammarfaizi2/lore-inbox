Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263276AbTAaXUZ>; Fri, 31 Jan 2003 18:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263313AbTAaXUY>; Fri, 31 Jan 2003 18:20:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16910 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263276AbTAaXUY>;
	Fri, 31 Jan 2003 18:20:24 -0500
Message-ID: <3E3B066B.8010905@pobox.com>
Date: Fri, 31 Jan 2003 18:27:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Perl in the toolchain
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu> <20030131194837.GC8298@gtf.org> <20030131213827.GA1541@werewolf.able.es>
In-Reply-To: <20030131213827.GA1541@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 2003.01.31 Jeff Garzik wrote:
> 
>>On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
>>
>>>Generally, we've been trying to not make perl a prequisite for the kernel 
>>>build, and I'd like to keep it that way. Except for some arch specific 
>>
>>That's pretty much out the window when klibc gets merged, so perl will
>>indeed be a build requirement for all platforms...
>>
> 
> 
> So in short, kernel people:
> - do not want perl in the kernel build
> - allow qt to pollute the kernel to have a decent gui config tool
> - have to rewrite half perl features in C
> - but perl will be needed anyways
> 
> instead of
> - do all parsing in perl, that is what perl is for and what is mainly done
>   in kconfig scripts
> - do the config backend in perl, and...
> - do the gui in perl-XXX, so you can have perl-GTK, perl-GTK2, perl-QT or 
>   perl-Tk, even perl-Xaw (so you get rid of tcl/tk)
> 
> I really do not understand...


Well, you appear to be taking the superset of opinions, which is 
guaranteed to generate a paradox, I should think ;-)

Specifically regarding kconf, it does not require Qt; Qt is merely an 
optional piece.

For Perl, yes I personally think it is needed anyway.  And re-creating 
Perl's features in C, just to avoid Perl, is not the best technical 
solution when developers already have Perl installed.

	Jeff



