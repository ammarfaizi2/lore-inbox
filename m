Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274434AbRJJOYt>; Wed, 10 Oct 2001 10:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275449AbRJJOYj>; Wed, 10 Oct 2001 10:24:39 -0400
Received: from t2.redhat.com ([199.183.24.243]:4599 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S274434AbRJJOYT>; Wed, 10 Oct 2001 10:24:19 -0400
Message-ID: <3BC45A2C.1F7754B1@redhat.com>
Date: Wed, 10 Oct 2001 15:24:44 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>, linux-kernel@vger.kernel.org
Subject: Re: Tainted Modules Help Notices
In-Reply-To: <F4C5F64C4EBBD51198AD009027D61DB31C8139@otcexc01.otc.adaptec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bonds, Deanna" wrote:
> 
> >
> > The kernel dpt_i2o is GPL. Its in part built from GPL'd code
> > I wrote but
> > mostly from what I assume was originally a  cross platform
> > dpt source set.
> >
> > Alan
> 
> The main dpt_i2o files are GPL.  There are some header files that are used
> for the ioctl interface that are used across all platforms and management
> utilities.  They were originally released under BDS license for the most
> flexibility.  But we have no problems in re-releasing them under GPL as long
> as we have the 'copy-back' right and can continue to use them in our other
> products.  All we would be concerned with is not having to GPL all the
> software that uses those headers (which is pretty much everything related to
> the i2o raid cards on every OS).

Then dual-licensing it with BSD and GPL sounds the way to go; quite a
few drivers
do that, and I can't imagine anyone having a problem with that.
