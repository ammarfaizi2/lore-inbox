Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135619AbREBQOb>; Wed, 2 May 2001 12:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbREBQOR>; Wed, 2 May 2001 12:14:17 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:63937 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S135617AbREBQNt>; Wed, 2 May 2001 12:13:49 -0400
Date: Wed, 2 May 2001 18:13:43 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: "Cabaniols, Sebastien" <Sebastien.Cabaniols@compaq.com>
cc: "'andrewm@uow.edu.au'" <andrewm@uow.edu.au>,
        "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: [3com905b freeze Alpha SMP 2.4.2] FullDuplex issue ?
In-Reply-To: <1FF17ADDAC64D0119A6E0000F830C9EA04B3CDCA@aeoexc1.aeo.cpqcorp.net>
Message-ID: <Pine.LNX.4.30.0105021801190.26143-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Cabaniols, Sebastien wrote:

> I insert the 3c59x module with debug=7.

Why ? debug=7 is the highest debug level and produces _lots_ of debug data
for high network activity. Do you have problems when insmod-ing without
any option and use a higher debug level just to see what's going on?

> The first of the above machines launching the get freezes.

Why do you believe that the card/driver is responsible for the freeze ?
The outputs that you provided show no problems to me.

A duplex mismatch would not freeze a computer. You would get crappy
transfer rates, usually some error messages from the driver, but
everything should otherwise work. To verify the media settings, you might
want to use mii-diag (from ftp.scyld.com).

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De


