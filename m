Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRBUQX3>; Wed, 21 Feb 2001 11:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129104AbRBUQXU>; Wed, 21 Feb 2001 11:23:20 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:3774 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129051AbRBUQXC>; Wed, 21 Feb 2001 11:23:02 -0500
Message-ID: <3A93EB51.C9D10316@ubishops.ca>
Date: Wed, 21 Feb 2001 11:22:41 -0500
From: Thomas Hood <jdthood@ubishops.ca>
Reply-To: jdthoodREMOVETHIS@yahoo.co.uk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
In-Reply-To: <20010214092251.D1144@e-trend.de> <3A8AA725.7446DEA0@ubishops.ca> <20010214165758.L28359@e-trend.de> <20010214122244.H7859@conectiva.com.br>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Update on the "unregister_netdevice" bug ...

Arnaldo Carvalho de Melo found one bug but there
remains another one that makes the dev->refcnt too
high instead of too low.

To be continued ...

Thomas
