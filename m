Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTEMOJs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 10:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbTEMOJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 10:09:48 -0400
Received: from orion.netbank.com.br ([200.203.199.90]:30980 "EHLO
	orion.netbank.com.br") by vger.kernel.org with ESMTP
	id S261265AbTEMOJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 10:09:47 -0400
Date: Tue, 13 May 2003 11:24:06 -0300
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [COMPILATION ERROR] 2.5.69-bk7 wireless.c:488: `THIS_MODULE' undeclared here
Message-ID: <20030513142406.GF23005@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
	lkml <linux-kernel@vger.kernel.org>
References: <1052834757.2268.13.camel@nalesnik> <1052835040.2227.18.camel@nalesnik>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052835040.2227.18.camel@nalesnik>
X-Url: http://advogato.org/person/acme
Organization: Conectiva S.A.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 13, 2003 at 03:10:48PM +0100, Grzegorz Jaskiewicz escreveu:
> On Tue, 2003-05-13 at 15:06, Grzegorz Jaskiewicz wrote:
> > net/core/wireless.c:488: `THIS_MODULE' undeclared here (not in a
> > function)
> > 
> > this bug was added with -bk7 patch
> solved : looks like #include <linux/modules.h> was missing in this file

Its already fixed in Linus tree and in the 2.5.69-bk snapshots.

Ditto for net/wanrouter/wanproc.c that I fixed yesterday.

- Arnaldo
