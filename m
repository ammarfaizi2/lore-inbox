Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbTEAUt5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 16:49:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTEAUt5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 16:49:57 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:22539 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S262627AbTEAUt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 16:49:56 -0400
Date: Thu, 1 May 2003 18:02:23 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: "Michael D. Harnois" <mharnois@cpinternet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at net/socket.c:147
Message-ID: <20030501210223.GH4535@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	"David S. Miller" <davem@redhat.com>,
	"Michael D. Harnois" <mharnois@cpinternet.com>,
	linux-kernel@vger.kernel.org
References: <1051821220.4440.1.camel@mharnois.mdharnois.net> <1051822567.10731.1.camel@rth.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1051822567.10731.1.camel@rth.ninka.net>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 01, 2003 at 01:56:07PM -0700, David S. Miller escreveu:
> On Thu, 2003-05-01 at 13:33, Michael D. Harnois wrote:
> > May  1 15:30:20 mharnois kernel: Process vmnet-bridge (pid: 9886,
> 
> VMWARE is buggy in it's socket/protocol handling.
> 
> Arnaldo, it triggered the net_family_bug() :-)

Oh well, we have to have more checks like that to catch buggy code. :-)

- Arnaldo
