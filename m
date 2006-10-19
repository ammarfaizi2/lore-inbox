Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751588AbWJSMIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751588AbWJSMIu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751587AbWJSMIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:08:49 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52442 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751581AbWJSMIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:08:49 -0400
Subject: Re: [NFS] NFS inconsistent behaviour
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Lever <chucklever@gmail.com>
Cc: Frank van Maarseveen <frankvm@frankvm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Mohit Katiyar <katiyar.mohit@gmail.com>,
       Linux NFS mailing list <nfs@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <76bd70e30610181317w3e8315e5m75056305904a1bce@mail.gmail.com>
References: <A93BD15112CD05479B1CD204F7F1D4730513DB@exch-04.noida.hcltech.com>
	 <20061016084656.GA13292@janus>
	 <46465bb30610160235m211910b6g2eb074aa23060aa9@mail.gmail.com>
	 <20061016093904.GA13866@janus>
	 <46465bb30610171822h3f747069ge9a170f1759af645@mail.gmail.com>
	 <20061018063945.GA5917@janus> <1161194229.6095.81.camel@lade.trondhjem.org>
	 <20061018183807.GA12018@janus>
	 <1161199580.6095.112.camel@lade.trondhjem.org>
	 <20061018200936.GA14733@janus>
	 <76bd70e30610181317w3e8315e5m75056305904a1bce@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2006 13:11:17 +0100
Message-Id: <1161259878.17335.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-18 am 16:17 -0400, ysgrifennodd Chuck Lever:
> Some discussion on both FreeBSD and Linux mailing lists suggests that
> ignoring TIME_WAIT has some risk to it, so that may not be an

Ignoring time wait leads to corrupted sessions and can lead to tcp food
fights. It exists for a reason although the protocol itself actually
does still have flaws in this area (which are kept in the locked
cupboard full of skeletons at the IETF 8) )

Alan
