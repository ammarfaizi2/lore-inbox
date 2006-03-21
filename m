Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751388AbWCUAh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbWCUAh5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 19:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWCUAh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 19:37:57 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:31619 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751383AbWCUAh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 19:37:56 -0500
Date: Mon, 20 Mar 2006 19:37:51 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: "David S. Miller" <davem@davemloft.net>
cc: chrisw@sous-sol.org, cxzhang@watson.ibm.com, netdev@axxeo.de,
       ioe-lkml@rameria.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] scm: fold __scm_send() into scm_send()
In-Reply-To: <20060320.152838.68858441.davem@davemloft.net>
Message-ID: <Pine.LNX.4.64.0603201936030.6749@excalibur.intercode>
References: <200603201244.58507.netdev@axxeo.de> <20060320201802.GS15997@sorel.sous-sol.org>
 <20060320213636.GT15997@sorel.sous-sol.org> <20060320.152838.68858441.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Mar 2006, David S. Miller wrote:

> I'm seriously considering backing out Catherine's AF_UNIX patch from
> the net-2.6.17 tree before submitting it to Linus later today so that
> none of this crap goes in right now.

I believe Catherine is away this week, so it's probably best to drop the 
code and wait till she gets back and we can get it 100% right.

Sorry, this is my fault, I should have caught this problem.



- James
-- 
James Morris
<jmorris@namei.org>
