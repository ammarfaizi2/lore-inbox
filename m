Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVH0F3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVH0F3f (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Aug 2005 01:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbVH0F3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Aug 2005 01:29:35 -0400
Received: from loncoche.terra.com.br ([200.176.10.196]:60054 "EHLO
	loncoche.terra.com.br") by vger.kernel.org with ESMTP
	id S1030305AbVH0F3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Aug 2005 01:29:34 -0400
X-Terra-Karma: -2%
X-Terra-Hash: fc3d284b2194191ba674bbe38dd7b065
Date: Sat, 27 Aug 2005 02:29:29 -0300
To: Robert Love <rml@novell.com>
Cc: dtor_core@ameritech.net, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] IBM HDAPS accelerometer driver, with probing.
Message-ID: <20050827052929.GA15782@mandriva.com>
Mail-Followup-To: acme@ghostprotocols.net,
	Robert Love <rml@novell.com>, dtor_core@ameritech.net,
	Andrew Morton <akpm@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1125094725.18155.120.camel@betsy> <d120d50005082615445557d776@mail.gmail.com> <1125099479.32272.29.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125099479.32272.29.camel@phantasy>
X-Url: http://advogato.org/person/acme
User-Agent: Mutt/1.5.9i
From: acme@ghostprotocols.net (Arnaldo Carvalho de Melo)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 26, 2005 at 07:37:59PM -0400, Robert Love escreveu:
> On Fri, 2005-08-26 at 17:44 -0500, Dmitry Torokhov wrote:
> 
> > Is this function used in a hot path to warrant using "unlikely"? There
> > are to many "unlikely" in the code for my taste.
> 
> unlikely() can result in better, smaller, faster code.  and it acts as a
> nice directive to programmers reading the code.

Agreed, keep them :-)

- Arnaldo
