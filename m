Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268442AbUHYDoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268442AbUHYDoq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 23:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268443AbUHYDoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 23:44:46 -0400
Received: from smtp3.pop.com.br ([200.175.8.37]:59801 "EHLO smtp3.pop.com.br")
	by vger.kernel.org with ESMTP id S268442AbUHYDoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 23:44:44 -0400
Message-ID: <1147.200.225.247.161.1093405482.squirrel@popmail5.pop.com.br>
In-Reply-To: <20040825020538.55821.qmail@web12306.mail.yahoo.com>
References: <200408250102.i7P12Bp08783@mail019.syd.optusnet.com.au>
    <20040825020538.55821.qmail@web12306.mail.yahoo.com>
Date: Wed, 25 Aug 2004 00:44:42 -0300 (BRT)
Subject: Re: NForce 2 support
From: "Rodrigo F Baroni" <rodrigobaroni@pop.com.br>
To: "Dr NoName" <spamacct11@yahoo.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: POPMail/1.4.2
X-POPMail-client-ip: 200.225.247.161
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dr NoName disse:
>> nforce 2 works sweet with the exception of sound
>> which has been broken in 2.6.7 and
>> 2.6.8.1 causing system crashes. If you have a
>> soundcard not to worry, if you are
>> gonna run onboard ... wait and see with 2.6.9 brings

  I got do my one work, but I spend some enoght time until get it work.
Following the "try/error" method, I got do it work by :

   1)Disabling the support to pnp
   2)Disabling the support to new irq automatic detect item
   3)Enabling only ALSA build-in (no open sound, as the docs say to do)
   4)Enabling evey option about ALSA, but about the specific chipset only the
one - NVidia2

  The machine was one with a asus A7N8X-X (nvidia2 chipset).

 Rodrigo F Baroni
