Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269964AbTGKNmm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 09:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269965AbTGKNmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 09:42:42 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:40381 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S269964AbTGKNml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 09:42:41 -0400
Date: Fri, 11 Jul 2003 15:57:16 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Brady <Alan.C.Brady@exeter.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 - minor config glitch
Message-ID: <20030711135716.GI10217@louise.pinerecords.com>
References: <1057924063.32461.61.camel@tactile.ex.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057924063.32461.61.camel@tactile.ex.ac.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [Alan.C.Brady@exeter.ac.uk]
> 
> Not a bug, but some apps choke when trying to parse the missing
> condition. 
> 
> /usr/src/linux-2.4.21//drivers/char/Config.in, line 161:
> 
> 	if [ "$CONFIG_PPC64" ] ; then 
>                    ^^^
> 
> I presume this should get set as
>  
> 	if [ "$CONFIG_PPC64" = "y" ] ; then

Would you post a -p1 patch, please?
Don't forget to CC the PPC64 maintainer(s).

-- 
Tomas Szepe <szepe@pinerecords.com>
