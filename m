Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262327AbVGLTlM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262327AbVGLTlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 15:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVGLTip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 15:38:45 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:63125 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S262335AbVGLThg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 15:37:36 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: kernel guide to space
To: Denis Vlasenko <vda@ilport.com.ua>, sander@humilis.net,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Tue, 12 Jul 2005 21:36:47 +0200
References: <4p851-3Tl-11@gated-at.bofh.it> <4p8HK-4he-19@gated-at.bofh.it> <4pmUD-7gx-37@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DsQYh-0000jo-UP@be1.lrz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@ilport.com.ua> wrote:

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

That's why you SHOULD NOT use tabs for aligning, but for indenting.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
