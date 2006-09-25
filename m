Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751179AbWIYUtX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751179AbWIYUtX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 16:49:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWIYUtW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 16:49:22 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:33166 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1751109AbWIYUtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 16:49:21 -0400
Message-ID: <451840CA.5060901@hp.com>
Date: Mon, 25 Sep 2006 16:49:14 -0400
From: Brian Haley <brian.haley@hp.com>
Organization: Open Source and Linux Organization
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Joerg Roedel <joro-lkml@zlug.org>
Cc: Valdis.Kletnieks@vt.edu, jamal <hadi@cyberus.ca>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Patrick McHardy <kaber@trash.net>, davem@davemloft.net,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 00/03][RESUBMIT] net: EtherIP tunnel driver
References: <20060923120704.GA32284@zlug.org> <20060923121327.GH30245@lug-owl.de> <1159015118.5301.19.camel@jzny2> <20060923132736.GA345@zlug.org> <200609250107.k8P17h8A019714@turing-police.cc.vt.edu> <20060925083249.GC23028@zlug.org>
In-Reply-To: <20060925083249.GC23028@zlug.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Roedel wrote:
>> Is there something in the RFC that suggests that a byte order other than
>> 'network order' is possible/acceptable there?
> 
> No. The RFC states nothing at all about byte- or bitorder. That is why
> the RFC is ambigious at this point.

RFC 791 (IPv4) Appendix B does give instructions on byte ordering for 
all IPv4 headers and data, and RFC 791 is listed in the References for 
RFC 3378.  I noticed this is only Informational, not a Standards track 
document, so I guess the non-interoperable implementations kind of go 
with the territory.

-Brian
