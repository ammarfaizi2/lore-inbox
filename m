Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316994AbSGELGV>; Fri, 5 Jul 2002 07:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSGELGU>; Fri, 5 Jul 2002 07:06:20 -0400
Received: from mailhub.fokus.gmd.de ([193.174.154.14]:21163 "EHLO
	mailhub.fokus.gmd.de") by vger.kernel.org with ESMTP
	id <S316994AbSGELGU> convert rfc822-to-8bit; Fri, 5 Jul 2002 07:06:20 -0400
From: Matthias Welk <welk@fokus.gmd.de>
Organization: Fraunhofer Fokus
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: problem: socket receivebuffer size
Date: Fri, 5 Jul 2002 13:08:30 +0200
User-Agent: KMail/1.4.5
Cc: linux-kernel@vger.kernel.org, Peter Gober <gober@fokus.gmd.de>
References: <200207051128.06598.welk@fokus.gmd.de> <20020705123822.W28720@mea-ext.zmailer.org>
In-Reply-To: <20020705123822.W28720@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200207051308.30827.welk@fokus.gmd.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 July 2002 11:38, Matti Aarnio wrote:
> On Fri, Jul 05, 2002 at 11:28:05AM +0200, Matthias Welk wrote:
> > Hi,
> >
> > I've a problem with sockets and the receive buffer size.
> > If the size is smaller than 831 (??) byte, I did not receive udp packets
> > (224 byte) any more.
>
>   Yes ?    Why are you setting it so low ?
>   Having there some larger value, like 64k, should not harm anything,
>   quite contrary.
>

The problem is, that the size is changed in an other program (Java Media 
Framework), where I have no chance to change the size :-(

Thanks, Matthias.
-- 
---------------------------------------------------------------
From: Matthias Welk                   office:  +49-30-3463-7272
      FHG Fokus                       mobile:  +49-179- 1144752
      Kaiserin-Augusta-Allee 31       fax   :  +49-30-3463-8672
      10589 Berlin		      email : welk@fokus.fhg.de
----------------------------------------------------------------

