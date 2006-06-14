Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWFNO0z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWFNO0z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 10:26:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbWFNO0z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 10:26:55 -0400
Received: from web53606.mail.yahoo.com ([206.190.37.39]:64397 "HELO
	web53606.mail.yahoo.com") by vger.kernel.org with SMTP
	id S964975AbWFNO0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 10:26:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=yhVFbQU+BP52nrdD8tQT8TnkOAjQcBxUtJduRGe6GWuxc6R519nPQ7UjdCgImVCPug/H0deIzOWvqe7y6lKV3NJ6VEWCpRPBNdTRV735YNhUz1i046h1H9CHz9pcbrMqRbfMfaNlTwRaDXXuT1GrKr1wQZ84RzgUuw14Gx/vm78=  ;
Message-ID: <20060614142653.71443.qmail@web53606.mail.yahoo.com>
Date: Wed, 14 Jun 2006 07:26:53 -0700 (PDT)
From: Jason <bofh1234567@yahoo.com>
Subject: Re: SO_REUSEPORT and multicasting
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0606132219420.11918@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >Does the kernel support SO_REUSEPORT?
> 
> IIRC no, *BSD being the only one(s) I know of.
> 
> > If so can
> >anyone give me some suggestions why my program does
> >not work on Linux?  I did a route add -net
> 224.0.0.0/4
> >dev eth0 but that did not do anything.
> >
> Have you bound to a multicast group in your program?

If BSD supports it why can't Linux?  

Yes.  My code works great on HP-UX but does nothing on
Linux.  It will not compile because it can't find
SO_REUSEPORT.  I don't have the exact error message at
hand, but I could send it if it would help.  If I
switch to SO_REUSEADDR the code compiles but the
server does not receive anything.

Thanks,




__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam
protection around 
http://mail.yahoo.com 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
