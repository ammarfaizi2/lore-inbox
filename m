Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264437AbRFOQRh>; Fri, 15 Jun 2001 12:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264438AbRFOQRT>; Fri, 15 Jun 2001 12:17:19 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:16610 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S264437AbRFOQQ4>; Fri, 15 Jun 2001 12:16:56 -0400
Date: Fri, 15 Jun 2001 18:16:45 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: "L. K." <lk@Aniela.EU.ORG>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 3C905B -- EEPROM (i blive so) problem
In-Reply-To: <Pine.LNX.4.21.0106131838110.30298-100000@ns1.Aniela.EU.ORG>
Message-ID: <Pine.LNX.4.33.0106151804330.13655-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001, L. K. wrote:

> I have a 3COM 3C905B ethernet card that has been hit by a power outage for
> aprox. 0.5 sec.

What do you mean by "power outage" ? If you mean cutting the power, this
is not a serious reason for EEPROM damages, unless you were modifying it
at that moment.

> I do belive something happened to the eeprom of the card. I would like
> to know if I can overwrite-it with a new one so that I can make my
> ethernet card work again.

Maybe 3Com's DOS-based tool (3c90xcfg.exe) can help.

In order to re-write the EEPROM, you need to use vortex-diag; I think that
you need to hack it a bit as the EEPROM writting code is not enabled. But
most important is that you need a good EEPROM image to write; if you have
another similar card, you can use vortex-diag to dump the EEPROM, then
change the MAC address (if you put both cards on the same network
segment). If you don't have a similar card... you have to download the
card's documentation from 3Com and build your own EEPROM image based on
what you know about your card's capabilities - having an EEPROM image from
a different card might screw things up badly.

If you decide to go the last way, maybe I can help with some
interpretation of the docs - please e-mail me in private.

Sincerely,

Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

