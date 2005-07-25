Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261272AbVGYOsk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVGYOsk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 10:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVGYOqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 10:46:23 -0400
Received: from fydelkass.inl.fr ([195.101.59.116]:47526 "EHLO hebus.inl.fr")
	by vger.kernel.org with ESMTP id S261239AbVGYOoG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 10:44:06 -0400
Subject: Re: Netlink connector
From: Eric Leblond <eleblond@inl.fr>
To: Patrick McHardy <kaber@trash.net>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Andrew Morton <akpm@osdl.org>,
       Harald Welte <laforge@netfilter.org>, netdev@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       netdev@redhat.com
In-Reply-To: <42E4F800.1010908@trash.net>
References: <20050723125427.GA11177@rama>
	 <20050723091455.GA12015@2ka.mipt.ru>
	 <20050724.191756.105797967.davem@davemloft.net>
	 <Lynx.SEL.4.62.0507250154000.21934@thoron.boston.redhat.com>
	 <20050725070603.GA28023@2ka.mipt.ru>  <42E4F800.1010908@trash.net>
Content-Type: text/plain; charset=iso-8859-15
Organization: INL
Date: Mon, 25 Jul 2005 16:43:43 +0200
Message-Id: <1122302623.29940.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 25 juillet 2005 à 16:32 +0200, Patrick McHardy a écrit :
> Evgeniy Polyakov wrote:
> > On Mon, Jul 25, 2005 at 02:02:10AM -0400, James Morris (jmorris@redhat.com) wrote:
> If I understand correctly it tries to workaround some netlink
> limitations (limited number of netlink families and multicast groups)
> by sending everything to userspace and demultiplexing it there.
> Same in the other direction, an additional layer on top of netlink
> does basically the same thing netlink already does. This looks like
> a step in the wrong direction to me, netlink should instead be fixed
> to support what is needed.

I totally agree with you, it could be great to fix netlink to support
multiple queue.
I like to be able to use projects like snort-inline or nufw together.
This will make Netfilter really stronger.
Furthermore, there's a repetition of filtering capabilities with such a
solution. Netfilter has to filter to send to netlink and this is the
same with the queue dispatcher. I think this introduce too much
complexity.
 
my 0.02$

BR,
-- 
Éric Leblond, eleblond@inl.fr
Téléphone : 01 44 89 46 40, Fax : 01 44 89 45 01
INL, http://www.inl.fr

