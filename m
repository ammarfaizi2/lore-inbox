Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWHKAqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWHKAqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 20:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWHKAqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 20:46:06 -0400
Received: from ozlabs.org ([203.10.76.45]:8836 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932396AbWHKAqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 20:46:03 -0400
To: Alexey Dobriyan <adobriyan@gmail.com>
cc: Jan-Bernd Themann <ossthema@de.ibm.com>, netdev@vger.kernel.org,
       Thomas Klein <tklein@de.ibm.com>, linuxppc-dev@ozlabs.org,
       Christoph Raisch <raisch@de.ibm.com>, linux-kernel@vger.kernel.org,
       Marcus Eder <meder@de.ibm.com>
From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/6] ehea: queue management 
In-reply-to: <20060811003204.GA6935@martell.zuzino.mipt.ru> 
References: <44D99F38.8010306@de.ibm.com> <20060811000540.200CE67B6B@ozlabs.org> <20060811003204.GA6935@martell.zuzino.mipt.ru>
Comments: In-reply-to Alexey Dobriyan <adobriyan@gmail.com>
   message dated "Fri, 11 Aug 2006 04:32:04 +0400."
Reply-to: Michael Neuling <mikey@neuling.org>
X-Mailer: MH-E 7.85; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 11 Aug 2006 10:46:01 +1000
Message-Id: <20060811004602.23EB467B64@ozlabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +static inline u32 map_swqe_size(u8 swqe_enc_size)
> > > +{
> > > +	return 128 << swqe_enc_size;
> > > +}		      ^
> > > +		      |
> > > +static inline u32|map_rwqe_size(u8 rwqe_enc_size)
> > > +{		      |
> > > +	return 128 << rwqe_enc_size;
> 		      ^
> > > +}		      |
> >		      |
> > Snap!  These are ide|tical...
> 		      |
> No, they aren't. -----+

Functionally identical.

Mikey
