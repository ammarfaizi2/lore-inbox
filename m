Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316838AbSFFG4Q>; Thu, 6 Jun 2002 02:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316840AbSFFG4P>; Thu, 6 Jun 2002 02:56:15 -0400
Received: from ns.tasking.nl ([195.193.207.2]:13843 "EHLO ns.tasking.nl")
	by vger.kernel.org with ESMTP id <S316838AbSFFG4O>;
	Thu, 6 Jun 2002 02:56:14 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15615.1785.296064.827700@koli.tasking.nl>
Date: Thu, 6 Jun 2002 08:53:45 +0200
From: Kees Bakker <rnews@altium.nl>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ov511 compilation failure 2.5.18 - struct urb has no next
In-Reply-To: <20020606063728.GA7200@kroah.com>
X-Mailer: VM 7.03 under Emacs 20.7.2
Reply-To: kees.bakker@altium.nl (Kees Bakker)
Organisation: ALTIUM Software B.V.
X-Bill: Go away
X-Attribution: kb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Greg" == Greg KH <greg@kroah.com> writes:

Greg> On Mon, Jun 03, 2002 at 02:41:21PM +0200, Kees Bakker wrote:
>> Since 2.5.18 I'm getting compilation errors in ov511.c.
>> ov511.c: In function `ov51x_init_isoc':
>> ov511.c:3978: structure has no member named `next'
>> ov511.c:3980: structure has no member named `next'
>> 
>> Struct member 'next' has been removed from struct urb.
>> 
>> Can I simply remove these lines that setup this 'ring'?

Greg> Sure, but odds are the driver will not work :)

Indeed it doesn't work :)

Greg> See the linux-usb-devel archives for instructions on how to convert this
Greg> kind of driver if you're interested in doing so.

Thanks for the pointer.
-- 
**************************************
Kees Bakker
Senior Software Designer
Altium - Think it, Design it, Build it
Phone  : +31 33 455 8584
Fax    : +31 33 455 5503
E-Mail : Kees.Bakker@altium.nl
URL    : http://www.altium.com
**************************************
Wait a moment... wait a moment... wait a moment...
