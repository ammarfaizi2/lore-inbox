Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTDPPzH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264536AbTDPPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:55:07 -0400
Received: from dsl-213-023-227-002.arcor-ip.net ([213.23.227.2]:46979 "EHLO
	server1.intern.kubla.de") by vger.kernel.org with ESMTP
	id S264535AbTDPPzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:55:05 -0400
From: Dominik Kubla <dominik@kubla.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, steve.cameron@hp.com
Subject: Re: How to identify contents of /lib/modules/*
Date: Wed, 16 Apr 2003 18:06:54 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030416020059.GA27314@zuul.cca.cpqcorp.net> <1050502898.28591.76.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1050502898.28591.76.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304161806.54817.dominik@kubla.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. April 2003 16:21 schrieb Alan Cox:
...
> if its an rpm based distro
>
> 	rpm -qf /lib/modules/[version]/something
>
> will tell you which kernel owns the file.
>
> Its a horrible thing to need to do however

And it's

	dpkg -S|--search /lib/modules/[version]/something

for dpkg-based distributions. 

Regards,
  Dominik
-- 
Those who can make you believe absurdities can make you commit
atrocities.    (Francois Marie Arouet aka Voltaire, 1694-1778)

