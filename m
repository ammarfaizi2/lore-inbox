Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263523AbRFAOCx>; Fri, 1 Jun 2001 10:02:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263527AbRFAOCn>; Fri, 1 Jun 2001 10:02:43 -0400
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:54195 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S263523AbRFAOCf>; Fri, 1 Jun 2001 10:02:35 -0400
Date: Fri, 1 Jun 2001 16:02:09 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: "David S. Miller" <davem@redhat.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Pete Zaitcev <zaitcev@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: [PATCH] support for Cobalt Networks (x86 only) systems (forrealthis
In-Reply-To: <15127.38509.495537.405210@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0106011556250.18082-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jun 2001, David S. Miller wrote:

> Don't such HA apps need to run as root anyways?

Not necessarily, but eventually you can let root (CAP_NET_ADMIN, anyway)
go through without any limitations, root can bring down the system at will
in other ways.

In addition, the rate limiting solution allows a warning to be issued when
the limit is exceeded, so that the poor sysadmin knows what hit him 8-)

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

