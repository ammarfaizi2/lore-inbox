Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261857AbTB0IOi>; Thu, 27 Feb 2003 03:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbTB0IOi>; Thu, 27 Feb 2003 03:14:38 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:3855 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261857AbTB0IOh>; Thu, 27 Feb 2003 03:14:37 -0500
Date: Thu, 27 Feb 2003 08:24:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>, bergner@vnet.ibm.com
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227082448.A27178@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>, bergner@vnet.ibm.com,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Feb 27, 2003 at 03:14:44AM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> <bergner@vnet.ibm.com>:
>   o Remove kdb from PowerPC-64
>   o ppc64 updates to 2.4.21-pre4

This removes the *xattr and tkill syscalls from ppc64 which is bogus.
It would be really nice if arch maintainers could actually follow mainline
instead of some vendor tree and do blind "fixups"..

