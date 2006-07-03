Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751277AbWGCUHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbWGCUHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWGCUHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 16:07:24 -0400
Received: from web32015.mail.mud.yahoo.com ([68.142.207.112]:6744 "HELO
	web32015.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751277AbWGCUHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 16:07:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nPpQq29JQNV2E8EDPPl2xoLlq0XPRRSyQ5JZdhVpwDmgjLaLqJ1VMzJ9bQ6zcd/2wv59jS0K0foM/qJrE5RRWr/yQvSlXOF6xRnDieJfeS479xZDAtVG8shVuIKTVTpibGUeICxvuvNIL4qVBB0hnvMNY7joWu2L1q9TnHjCEM8=  ;
Message-ID: <20060703200723.85857.qmail@web32015.mail.mud.yahoo.com>
Date: Mon, 3 Jul 2006 13:07:23 -0700 (PDT)
From: Congjun Yang <congjuny@yahoo.com>
Subject: Re: keyboard raw mode
To: Dmitry Torokhov <dtor@insightbb.com>
Cc: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
In-Reply-To: <200607021111.30386.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

AWESOME!!! (except that atkbd still complains about
unknown keycodes;)

--- Dmitry Torokhov <dtor@insightbb.com> wrote:

> On Sunday 02 July 2006 04:21, Congjun Yang wrote:
> > 2.6.9-22.EL(CentOS 4.2) is what I currently use.
> > 2.4.20 was where I first saw, in keyboard.c, the
> > workaround that throws away a second break code.
> > 
> 
> I think it should work in 2.6.9... The change was
> put in in summer
> of 2004, 2.6.9 was released in fall...
> 
> Try booting with atkbd.softraw=0 to turn off
> software rawmode
> emulation and I think you will see all the codes
> from your
> device.
> 
> > I think I like the new design for the user input
> > system: separate the protocol layer from the raw
> port.
> > But, would it be nice for the atkbd driver to
> still
> > provide a raw (or passthrough) mode?
> > 
> 
> It does ;)
> 
> -- 
> Dmitry
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
