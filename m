Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVAIUo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVAIUo1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 15:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVAIUo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 15:44:27 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:18703 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261759AbVAIUoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 15:44:22 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Badari Pulavarty <pbadari@us.ibm.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [RFC] 2.4 and stack reduction patches
Date: Sat, 8 Jan 2005 23:34:07 +0200
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1105112886.4000.87.camel@dyn318077bld.beaverton.ibm.com> <20050107141224.GF29176@logos.cnet> <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
In-Reply-To: <1105134173.4000.105.camel@dyn318077bld.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501082334.07880.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the single crude patch for one of the distro releases.
> (may not apply to latest 2.4 mainline). 

+       if (!bprmp) {
+               retval = -ENOMEM;
+               return retval;
+       }

You can just return -ENOMEM...
--
vda

