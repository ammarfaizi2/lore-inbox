Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVCRCrm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVCRCrm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 21:47:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261436AbVCRCrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 21:47:41 -0500
Received: from ensim03.ffm.m2soft.com ([195.38.20.12]:41191 "EHLO
	ensim03.ffm.m2soft.com") by vger.kernel.org with ESMTP
	id S261389AbVCRCri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 21:47:38 -0500
X-ClientAddr: 81.223.107.85
Date: Fri, 18 Mar 2005 03:46:20 +0100
From: Nicolas Kaiser <nikai@nikai.net>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, domen@coderock.org
Subject: Re: [patch 12/12] scripts/mod/sumversion.c: replace strtok() with
 strsep()
Message-ID: <20050318034620.0a8ac96d@lucky.kitzblitz>
In-Reply-To: <20050317212302.GB13119@mars.ravnborg.org>
References: <20050305153545.9769F1F1F0@trashy.coderock.org>
	<20050317212302.GB13119@mars.ravnborg.org>
Organization: -
X-Face: "fF&[w2"Nws:JNH4'g|:gVhgGKLhj|X}}&w&V?]0=,7n`jy8D6e[Jh=7+ca|4~t5e[ItpL5
 N'y~Mvi-vJm`"1T5fi1^b!&EG]6nW~C!FN},=$G?^U2t~n[3;u\"5-|~H{-5]IQ2
X-Mailer: Sylpheed-claws (Linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-M2Soft-MailScanner-Information: Please contact the ISP for more information
X-M2Soft-MailScanner: Found to be clean
X-MailScanner-From: nikai@nikai.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Sam Ravnborg <sam@ravnborg.org>:

> On Sat, Mar 05, 2005 at 04:35:45PM +0100, domen@coderock.org wrote:
> > 
> > Replaces strtok() with strsep()
> 
> Why - does it increase portability?

 "strtok() is not thread and SMP safe and strsep() should be
used instead"

http://janitor.kernelnewbies.org/docs/driver-howto.html#3.3.1

Cheers,
n.
