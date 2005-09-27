Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964790AbVI0BiD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964790AbVI0BiD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 21:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964794AbVI0BiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 21:38:03 -0400
Received: from qproxy.gmail.com ([72.14.204.205]:18590 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964790AbVI0BiC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 21:38:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qh3KWoxsTHolNrbYbkSmpFey5fnxc9p51AwkSLsUN9mvOP0XuViJLSiFT0SfSmt4MaxshNFt4aGH66VOhJU+5nArrLAXX/b7ZinKNwJiaY29wzKFbbZYbKwacDq+ky3pB+nm3qRXFCnOxMaMhWFJPBwJdI+TGHwMqCuo0DSFz3A=
Message-ID: <489ecd0c05092618372a5993c5@mail.gmail.com>
Date: Tue, 27 Sep 2005 09:37:59 +0800
From: Luke Yang <luke.adi@gmail.com>
Reply-To: Luke Yang <luke.adi@gmail.com>
To: Robert Schwebel <r.schwebel@pengutronix.de>
Subject: Re: ADI Blackfin porting for kernel-2.6.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050924145102.GD28883@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <489ecd0c05091923336b48555@mail.gmail.com>
	 <20050920071514.GA10909@plexity.net>
	 <489ecd0c050922223736cf1548@mail.gmail.com>
	 <20050924145102.GD28883@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 We really don't have plan about Blackfin with a MMU now.  So do you
beleve it is necessary to change the name to arch/blackfin?

On 9/24/05, Robert Schwebel <r.schwebel@pengutronix.de> wrote:
> On Fri, Sep 23, 2005 at 01:37:03PM +0800, Luke Yang wrote:
> > This patch mainly includes the arch/bfinnommu architecture files and
> > some blackfin specific drivers.
>
> Having in mind the pain with arm and m68k with and without MMU, could
> you structure that thing in a way that it will be able to share the
> current nommu code with (hopefully coming) code for blackfins which
> might have a MMU? So it would be something like arch/blackfin.
>
> Robert
> --
>  Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
>  Pengutronix - Linux Solutions for Science and Industry
>    Handelsregister:  Amtsgericht Hildesheim, HRA 2686
>      Hannoversche Str. 2, 31134 Hildesheim, Germany
>    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
>
>
