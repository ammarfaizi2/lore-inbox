Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261452AbSIWV33>; Mon, 23 Sep 2002 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261450AbSIWV3D>; Mon, 23 Sep 2002 17:29:03 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:65226 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261449AbSIWV1b>;
	Mon, 23 Sep 2002 17:27:31 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15759.34928.552606.829570@napali.hpl.hp.com>
Date: Mon, 23 Sep 2002 14:32:32 -0700
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, dmo@osdl.org, axboe@suse.de,
       phillips@arcor.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
In-Reply-To: <20020923.141752.91362457.davem@redhat.com>
References: <15759.32569.964762.776074@napali.hpl.hp.com>
	<20020923.135708.10698522.davem@redhat.com>
	<15759.34428.608321.969391@napali.hpl.hp.com>
	<20020923.141752.91362457.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Mon, 23 Sep 2002 14:17:52 -0700 (PDT), "David S. Miller" <davem@redhat.com> said:

  DaveM> I'm saying we define writeq() to be implementable as two 32-bit
  DaveM> transations, that will be the API.

Ah, OK, if it's documented that way (with the option of implementing
it as a single 64-bit store).

	--david
