Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135653AbRDSM5C>; Thu, 19 Apr 2001 08:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135652AbRDSM4x>; Thu, 19 Apr 2001 08:56:53 -0400
Received: from nef.ens.fr ([129.199.96.32]:5646 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id <S135649AbRDSM4j>;
	Thu, 19 Apr 2001 08:56:39 -0400
Date: Thu, 19 Apr 2001 14:56:37 +0200
From: =?ISO-8859-1?Q?=C9ric?= Brunet <ebrunet@quatramaran.ens.fr>
Message-Id: <200104191256.OAA31141@quatramaran.ens.fr>
To: linux-kernel@vger.kernel.org
Subject: Re: Children first in fork
In-Reply-To: <NCBBLIEPOCNJOAEKBEAKAEEJOHAA.davids@webmaster.com>
In-Reply-To: <20010419133538.A28654@quatramaran.ens.fr> <NCBBLIEPOCNJOAEKBEAKAEEJOHAA.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ens.mailing-lists.linux-kernel, you wrote:
>	It seems to me that what you really want is a fork option to create the
>child in a suspended state.

Yes, or a clone option (using ptrace, I can always change on the fly 
the fork system call into a clone system call and add whatever option I
want). But I would just like to be sure that there are no mechanism
already available by which it is possible to ptrace reliably a child.

Éric Brunet
