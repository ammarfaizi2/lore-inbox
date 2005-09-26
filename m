Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932350AbVIZW3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932350AbVIZW3M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVIZW3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:29:11 -0400
Received: from mail.avalus.com ([195.82.114.197]:24754 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S932350AbVIZW3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:29:10 -0400
Date: Mon, 26 Sep 2005 23:29:01 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Joel Schopp <jschopp@austin.ibm.com>, Andrew Morton <akpm@osdl.org>
Cc: Joel Schopp <jschopp@austin.ibm.com>,
       lhms <lhms-devel@lists.sourceforge.net>,
       Linux Memory Management List <linux-mm@kvack.org>,
       linux-kernel@vger.kernel.org, Mel Gorman <mel@csn.ul.ie>,
       Mike Kravetz <kravetz@us.ibm.com>,
       Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH 4/9] defrag helper functions
Message-ID: <C50046EE58FA62242E92877C@[192.168.100.25]>
In-Reply-To: <43385594.3080303@austin.ibm.com>
References: <4338537E.8070603@austin.ibm.com>
 <43385594.3080303@austin.ibm.com>
X-Mailer: Mulberry/4.0.3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--On 26 September 2005 15:09 -0500 Joel Schopp <jschopp@austin.ibm.com> 
wrote:

> +void assign_bit(int bit_nr, unsigned long* map, int value)

Maybe:
static inline void assign_bit(int bit_nr, unsigned long* map, int value)

it's short enough

>  +static struct page *
> +fallback_alloc(int alloctype, struct zone *zone, unsigned int order)
> +{
> +       /* Stub out for seperate review, NULL equates to no fallback*/
> +       return NULL;
> +
> +}

Maybe "static inline" too.

--
Alex Bligh
