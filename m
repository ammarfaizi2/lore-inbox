Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbUDRFBo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 01:01:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264118AbUDRFBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 01:01:44 -0400
Received: from florence.buici.com ([206.124.142.26]:40576 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264116AbUDRFBn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 01:01:43 -0400
Date: Sat, 17 Apr 2004 22:01:41 -0700
From: Marc Singer <elf@buici.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Marc Singer <elf@buici.com>, linux-kernel@vger.kernel.org
Subject: Re: NFS and kernel 2.6.x
Message-ID: <20040418050141.GA19414@flea>
References: <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org> <pan.2004.04.17.16.44.00.630010@smurf.noris.de> <1082225747.2580.18.camel@lade.trondhjem.org> <20040417183219.GB3856@flea> <1082228313.2580.25.camel@lade.trondhjem.org> <20040417222258.GA12893@flea> <1082249866.3619.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082249866.3619.43.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 05:57:46PM -0700, Trond Myklebust wrote:
> On Sat, 2004-04-17 at 15:22, Marc Singer wrote:
> > I have a data point for comparison.
> > 
> > I'm copying a 40MiB file over NFS.  In five trials, the mean transfer
> > times are
> > 
> >   UDP (v2):  48.5s
> >   TCP (v3):  52.7s
> 
> Against what kind of server on what kind of network, with what kind of
> mount options?
> The above would be quite reasonable performance on a 10Mbit network
> against a filer or a Linux server with the (insecure) "async" option
> set.

Client is a 200MHz ARM; server is a Linux host running 2.6.3 with the
kernel nfs daemon; network is 100Mib.  There is nothing else on the
network except intermittent broadband traffic.  Async is set on the
server side.

While I have seen much worse performance in the last couple of weeks,
I cannot blame NFS when I look at the numbers.
 
