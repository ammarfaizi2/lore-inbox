Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262110AbVEFBbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbVEFBbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 21:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbVEFBbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 21:31:45 -0400
Received: from s-utl01-nypop.stsn.com ([199.106.90.52]:60638 "HELO
	s-utl01-nypop.stsn.com") by vger.kernel.org with SMTP
	id S262110AbVEFBbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 21:31:41 -0400
Subject: Re: [PATCH] enable CONFIG_RTAS_PROC by default
From: Arjan van de Ven <arjan@infradead.org>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, johnrose@austin.ibm.com, linux-kernel@vger.kernel.org,
       anton@samba.org
In-Reply-To: <17018.51064.311305.718975@cargo.ozlabs.ibm.com>
References: <17018.51064.311305.718975@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 05 May 2005 21:31:06 -0400
Message-Id: <1115343066.6503.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-06 at 11:25 +1000, Paul Mackerras wrote:
> This patch enables CONFIG_RTAS_PROC by default on pSeries.  This will
> preserve /proc/ppc64/rtas/rmo_buffer, which is needed by librtas.


shouldn't this move over to sysfs at some point, to some firmware
directory ?


