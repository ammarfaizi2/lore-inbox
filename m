Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264098AbUDRA5t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 20:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbUDRA5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 20:57:49 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:38016
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S264103AbUDRA5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 20:57:47 -0400
Subject: Re: NFS and kernel 2.6.x
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marc Singer <elf@buici.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040417222258.GA12893@flea>
References: <20040416011401.GD18329@widomaker.com>
	 <1082079061.7141.85.camel@lade.trondhjem.org>
	 <20040415185355.1674115b.akpm@osdl.org>
	 <1082084048.7141.142.camel@lade.trondhjem.org>
	 <20040416045924.GA4870@linuxace.com>
	 <1082093346.7141.159.camel@lade.trondhjem.org>
	 <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
	 <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea>
	 <1082228313.2580.25.camel@lade.trondhjem.org> <20040417222258.GA12893@flea>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082249866.3619.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 17 Apr 2004 17:57:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-04-17 at 15:22, Marc Singer wrote:
> I have a data point for comparison.
> 
> I'm copying a 40MiB file over NFS.  In five trials, the mean transfer
> times are
> 
>   UDP (v2):  48.5s
>   TCP (v3):  52.7s

Against what kind of server on what kind of network, with what kind of
mount options?
The above would be quite reasonable performance on a 10Mbit network
against a filer or a Linux server with the (insecure) "async" option
set.

Cheers,
  Trond
