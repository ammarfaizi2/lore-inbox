Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265978AbUAKUzR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 15:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265980AbUAKUzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 15:55:17 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:58514
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265978AbUAKUzO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 15:55:14 -0500
Subject: Re: 2.6.1: data corrupton when recieving files > 1GB over network
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: yoann <informatique@mistur.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <btsaum$g7f$1@sea.gmane.org>
References: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
	 <btsaum$g7f$1@sea.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073854512.4967.18.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 15:55:12 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 11/01/2004 klokka 15:16, skreiv yoann:
> same file : /mnt/multimedia/iso
> 
> - mistur local (ext3) 2.4.18-1-686 :
>    ca679b3b8e28be00b98b007611384958  /mnt/multimedia/iso/woody-cd1.iso
> 
> - vaka remote (nfs) 2.4.18-bf2.4 :
>    ea34f974bdcfb2a678a97afb1fb4077d  /mnt/multimedia/iso/woody-cd1.iso
> 
> - vaka remote (nfs) 2.6.1-mm2 :
>    ca679b3b8e28be00b98b007611384958  /mnt/multimedia/iso/woody-cd1.iso
>    2798b3e2b97ca8082049c9207c291ebb  /mnt/multimedia/iso/woody-cd1.iso

Have you tried running memtest86 on these machines?

Also, is all this being done using the same 2.4.18-1 server on 'mistur',
or are you also using a server on 'vaka'? If the former, have you tried
changing servers? (BTW: is this the kernel server, or are you using the
userland nfs-server daemon).

Cheers,
  Trond
