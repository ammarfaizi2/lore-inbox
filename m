Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275816AbRJJOGi>; Wed, 10 Oct 2001 10:06:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275818AbRJJOG3>; Wed, 10 Oct 2001 10:06:29 -0400
Received: from magic.adaptec.com ([208.236.45.80]:62110 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S275816AbRJJOGL>; Wed, 10 Oct 2001 10:06:11 -0400
Message-ID: <F4C5F64C4EBBD51198AD009027D61DB31C8139@otcexc01.otc.adaptec.com>
From: "Bonds, Deanna" <Deanna_Bonds@adaptec.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, sirmorcant@morcant.org
Cc: linux-kernel@vger.kernel.org
Subject: RE: Tainted Modules Help Notices
Date: Wed, 10 Oct 2001 10:06:29 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> The kernel dpt_i2o is GPL. Its in part built from GPL'd code 
> I wrote but
> mostly from what I assume was originally a  cross platform 
> dpt source set.
> 
> Alan

The main dpt_i2o files are GPL.  There are some header files that are used
for the ioctl interface that are used across all platforms and management
utilities.  They were originally released under BDS license for the most
flexibility.  But we have no problems in re-releasing them under GPL as long
as we have the 'copy-back' right and can continue to use them in our other
products.  All we would be concerned with is not having to GPL all the
software that uses those headers (which is pretty much everything related to
the i2o raid cards on every OS).  

Deanna

