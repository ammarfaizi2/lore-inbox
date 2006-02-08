Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030401AbWBHBZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030401AbWBHBZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 20:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWBHBZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 20:25:56 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:21399 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030401AbWBHBZz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 20:25:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kzFRgwlD7vLhYhcUqg59KTLylXbPXkmXZTkL+fmPQRYpV5DZqeDj64k+E2PVbZYTbtpE75rfAaqRvQkezaLgrkpjz3Eh7DDMw2Y5dJ2VCrojAeuXwkZzrXfS2Bzf476fPfJlOu5sOHhDaqQnqD7T7iiC+zQALcABrxQs7He+1uU=
From: Neal Becker <ndbecker2@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Date: Tue, 7 Feb 2006 20:25:51 -0500
User-Agent: KMail/1.9.1
Cc: Greg KH <greg@kroah.com>, Dave Jones <davej@redhat.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <20060208000715.GA19233@kroah.com> <200602080110.06736.ak@suse.de>
In-Reply-To: <200602080110.06736.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602072025.51573.ndbecker2@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 February 2006 7:10 pm, Andi Kleen wrote:
> On Wednesday 08 February 2006 01:07, Greg KH wrote:
> > > In the meantime, here's what I got..
> > >
> > > http://people.redhat.com/davej/DSC00148.JPG
> >
> > Andi, didn't your change for this function make it into Linus's tree?
>
> Yes
>
> See
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=comm
>it;h=1de6bf33bc4601d856c286ad5c7d515468e24bbb
>
> Workaround is pci=nommconf btw
>

Yes!  This patch worked.
