Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319391AbSILAse>; Wed, 11 Sep 2002 20:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319392AbSILAsd>; Wed, 11 Sep 2002 20:48:33 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:19718 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319391AbSILAsc>;
	Wed, 11 Sep 2002 20:48:32 -0400
Date: Wed, 11 Sep 2002 17:50:03 -0700
From: Greg KH <greg@kroah.com>
To: Bob_Tracy <rct@gherkin.frus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.X config: USB speedtouch driver
Message-ID: <20020912005003.GA30380@kroah.com>
References: <20020910190424.GA22753@kroah.com> <m17oqw9-0005khC@gherkin.frus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m17oqw9-0005khC@gherkin.frus.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 02:44:37PM -0500, Bob_Tracy wrote:
> Greg KH wrote:
> > On Tue, Sep 10, 2002 at 01:53:45PM -0500, Bob_Tracy wrote:
> > > Minor nit: the subject driver depends on ATM, so a config-time check to
> > > see if ATM support is enabled is appropriate.
> > 
> > Agreed, patch? :)
> 
> Ok.  You shamed me into it :-).  If I understand how dep_tristate works,
> the attached one-liner should do the trick.  Sorry for doing this as an
> attachment, but I've seen my mailer mangle stuff when I try to include
> it in-line :-(.

Looks good, I've applied this to my tree.

thanks,

greg k-h
