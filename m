Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263981AbTDNWxx (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263988AbTDNWxx (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:53:53 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10172
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263981AbTDNWxv (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:53:51 -0400
Subject: Re: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030414222723.GA26161@suse.de>
References: <20030414222110.GK9640@fs.tum.de>
	 <20030414222723.GA26161@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050357987.26525.24.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Apr 2003 23:06:28 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-04-14 at 23:27, Dave Jones wrote:
> On Tue, Apr 15, 2003 at 12:21:10AM +0200, Adrian Bunk wrote:
>  > If my patch is wrong and this is a RTFM please give me a hint where to 
>  > find the "M".
>  > 
>  > The AMD K6-II and K6-III do support 3DNow!
> 
> The 3dnow memory copies aren't a win on anything
> earlier than an Athlon iirc.

Under 1% on a K6. The processor is so horribly memory bound the
actual copy function is borderline irrelevant. If its not in the
K6-III cache its not arriving in a hurry

