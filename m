Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbULPUoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbULPUoA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 15:44:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261983AbULPUn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 15:43:59 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:50048 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262019AbULPUlN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 15:41:13 -0500
Message-ID: <41C1F301.1070403@tmr.com>
Date: Thu, 16 Dec 2004 15:41:37 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Antonio_P=E9rez?= <aperlu@telefonica.net>
CC: Giuliano Pochini <pochini@shiny.it>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
References: <20041213212603.4e698de6.pochini@shiny.it><20041213212603.4e698de6.pochini@shiny.it> <41BE1399.8010300@telefonica.net>
In-Reply-To: <41BE1399.8010300@telefonica.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonio Pérez wrote:

> add this:
> echo 0 > /proc/sys/net/ipv4/tcp_bic
> echo 0 > /proc/sys/net/ipv4/tcp_ecn
> echo 0 > /proc/sys/net/ipv4/tcp_vegas_conf_avoid

I've seen this and similar advice for other problems, and have disabled 
ecn for several systems with networking ailments myself. Would it be 
better to have some of these off by default rather than have multiple 
versions of these problems appear into the future? Is there some common 
case where these not only work but provide a significant benefit so 
great it justifies being the default?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
