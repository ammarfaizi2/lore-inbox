Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbTLIQHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 11:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266086AbTLIQHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 11:07:15 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:16559 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S266051AbTLIQHN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 11:07:13 -0500
From: Vladimir Saveliev <vs@namesys.com>
Organization: namesys
To: Stephan von Krawczynski <skraw@ithnet.com>
Subject: Re: [2.4.23] kernel BUG at page_alloc.c:235!
Date: Tue, 9 Dec 2003 19:07:04 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200312081939.07390.vs@namesys.com> <20031209165926.18a5c3fa.skraw@ithnet.com>
In-Reply-To: <20031209165926.18a5c3fa.skraw@ithnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312091907.04707.vs@namesys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 18:59, Stephan von Krawczynski wrote:
> On Mon, 8 Dec 2003 19:39:07 +0300
> Vladimir Saveliev <vs@namesys.com> wrote:
> 
> > Hi
> > 
> > A program which reads spontaneously 4k blocks from a device (sda1) causes the following quite fast.
> 
> > [...]
> > Ksymoops provides
> > 
> > vs@tribesman:/tmp/> ksymoops -m System.map file2 -V -O -K
> > ksymoops 2.4.9 on i686 2.4.21-144-default.  Options used
> 
> What kind of a kernel is this? Are you sure you are running 2.4.23 ?
> 
Yes, oops happened on 2.4.23. I ksymoopsed it with proper System.map having 2.4.21-144 running, though

> 
> Regards,
> Stephan
> 
> 

