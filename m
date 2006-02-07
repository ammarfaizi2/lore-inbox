Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWBGXcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWBGXcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbWBGXcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:32:35 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:58648 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030212AbWBGXcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:32:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=AtIvYzTIkplAKODWISfI7iovlHyyo5nbsvXlhMoD66z8t80iak76pVi8aEUTJ2LdZ2M8/P6ONH5sGBdqYG/EUqHVpQdnfSmtUCTcR/4W7XhnK+/jeGglVPZmmmW6V4N8kbPHhzj1VDqkLUWReeS/W0fztDoLcBTPqxCpVFMLAsE=
From: Neal Becker <ndbecker2@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Date: Tue, 7 Feb 2006 18:32:28 -0500
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <20060207145913.714fec1c.akpm@osdl.org> <20060207231835.GA19648@kroah.com>
In-Reply-To: <20060207231835.GA19648@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602071832.28361.ndbecker2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 6:18 pm, Greg KH wrote:
> On Tue, Feb 07, 2006 at 02:59:13PM -0800, Andrew Morton wrote:
> > Neal Becker <ndbecker2@gmail.com> wrote:
> > > Sorry, I meant 2.6.16-rc1 (not 2.6.12)
> > >
> > > Neal Becker wrote:
> > > > HP dv8000 notebook
> > > > 2.6.15 is fine, but 2.6.12-rc1 panics immediately on startup
> > > >
> > > > Here is a picture of some traceback
> > > > https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=
> > > >view
> >
> > It died in pci_mmcfg_read().  Greg, didn't a crash in there get fixed
> > recently?
>
> Yes.  Can you try 2.6.16-rc2?  Is this a x86-64 machine?
>
> thanks,
>

This is 2.6.16-rc2.  Yes, this is an x86-64.  I have a new picture, I put 
here:

http://nbecker.dyndns.org:8080/imgp0361.jpg
