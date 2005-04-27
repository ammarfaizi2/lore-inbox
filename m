Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVD0FQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVD0FQj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 01:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVD0FQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 01:16:39 -0400
Received: from smtp804.mail.sc5.yahoo.com ([66.163.168.183]:27242 "HELO
	smtp804.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261482AbVD0FQg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 01:16:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: johnpol@2ka.mipt.ru
Subject: Re: [1/1] connector/CBUS: new messaging subsystem. Revision number next.
Date: Wed, 27 Apr 2005 00:16:33 -0500
User-Agent: KMail/1.8
Cc: netdev@oss.sgi.com, Greg KH <greg@kroah.com>,
       Jamal Hadi Salim <hadi@cyberus.ca>, Kay Sievers <kay.sievers@vrfy.org>,
       Herbert Xu <herbert@gondor.apana.org.au>,
       James Morris <jmorris@redhat.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Thomas Graf <tgraf@suug.ch>, Jay Lan <jlan@engr.sgi.com>
References: <20050411125932.GA19538@uganda.factory.vocord.ru> <d120d500050426130250ff9632@mail.gmail.com> <1114574809.14282.10.camel@uganda>
In-Reply-To: <1114574809.14282.10.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504270016.34002.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 26 April 2005 23:06, Evgeniy Polyakov wrote:
> Let's clarify that we are talking about userspace->kernelspace
> direction.
> Only for that messages callback path is invoked.

What about kernelspace->userspace or kernelspace->kernelspace?
>From what I see nothing stops kernel code from calling cn_netlink_send,
in fact your cbus does exactly that. So I am confused why you singled
out userspace->kernelspace direction.

-- 
Dmitry
