Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWG1IVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWG1IVK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbWG1IVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:21:10 -0400
Received: from dee.erg.abdn.ac.uk ([139.133.204.82]:10884 "EHLO erg.abdn.ac.uk")
	by vger.kernel.org with ESMTP id S932585AbWG1IVJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:21:09 -0400
From: Gerrit Renker <gerrit@erg.abdn.ac.uk>
Organization: Electronics Research Group, UoA
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCHv2 2.6.18-rc1-mm2 1/3] net: UDP-Lite generic support
Date: Fri, 28 Jul 2006 09:19:55 +0100
User-Agent: KMail/1.8.3
Cc: akpm@osdl.org, yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru,
       jmorris@namei.org, kaber@coreworks.de, pekkas@netcore.fi,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200607141719.02766@strip-the-willow> <20060727.223010.63131639.davem@davemloft.net>
In-Reply-To: <20060727.223010.63131639.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607280919.55482@strip-the-willow>
X-ERG-MailScanner: Found to be clean
X-ERG-MailScanner-From: gerrit@erg.abdn.ac.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

thank you very much for taking time to revise the code 
and for the detailed comments.


|  The amount of code duplication is absolutely enormous and
|  totally unnecessary.
You are right. 
So far I thought it better to keep UDP and UDP-Lite separate but an
intelligent code integration does seem the better way.


<snip>
|  It's mostly clerical work, but it will mean that we will have one
|  copy of all this code and as a result we won't even need a config
|  option for UDP-Lite.

I will start with the v4-side and post a small RFC patch to see whether
I got the concepts right. (Due to vacation, this will not before mid/end 
of August.)



Best regards
Gerrit
