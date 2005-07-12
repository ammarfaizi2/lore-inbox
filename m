Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVGLL7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVGLL7a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 07:59:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261371AbVGLL5f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 07:57:35 -0400
Received: from p54A0B88C.dip0.t-ipconnect.de ([84.160.184.140]:50685 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261355AbVGLLzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 07:55:36 -0400
Message-ID: <42D3AFA1.2090203@trash.net>
Date: Tue, 12 Jul 2005 13:55:13 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>
CC: sander@humilis.net, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
References: <20050711145616.GA22936@mellanox.co.il> <20050711153447.GA19848@favonius> <200507120952.04279.vda@ilport.com.ua>
In-Reply-To: <200507120952.04279.vda@ilport.com.ua>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> text with 8-char tabs:
> 
> struct s {
>         int n;          /* comment */
>         unsigned int u; /* comment */
> };
> 
> Same text viewed with tabs set to 4-char width:
> 
> struct s {
>     int n;      /* comment */
>     unsigned int u; /* comment */
> };
> 
> Comments are not aligned anymore

Best rule IMO is to use tabs for indentation and spaces for alignment.
This way tab size can be changed without breaking alignment.
