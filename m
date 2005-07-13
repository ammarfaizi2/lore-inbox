Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVGMFrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVGMFrP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVGMFrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:47:14 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:53401 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262596AbVGMFrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:47:08 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: 7eggert@gmx.de, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>,
       sander@humilis.net, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space
Date: Wed, 13 Jul 2005 08:46:36 +0300
User-Agent: KMail/1.5.4
References: <4p851-3Tl-11@gated-at.bofh.it> <4pmUD-7gx-37@gated-at.bofh.it> <E1DsQYh-0000jo-UP@be1.lrz>
In-Reply-To: <E1DsQYh-0000jo-UP@be1.lrz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507130846.36128.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 July 2005 22:36, Bodo Eggert wrote:
> Denis Vlasenko <vda@ilport.com.ua> wrote:
> 
> > text with 8-char tabs:
> > 
> > struct s {
> >         int n;          /* comment */
> >         unsigned int u; /* comment */
> > };
> > 
> > Same text viewed with tabs set to 4-char width:
> > 
> > struct s {
> >     int n;      /* comment */
> >     unsigned int u; /* comment */
> > };
> > 
> > Comments are not aligned anymore
> 
> That's why you SHOULD NOT use tabs for aligning, but for indenting.

Doesn't work either: 8-char tabs:

		int i;  /* comment */
	};
	int j;          /* comment */

4-char tabs:

	int i;  /* comment */
    };
    int j;          /* comment */

So we can either ban tabs altogether (unlikely) or agree
that pi is ~= 3.1415926535897932384626433832795028841971693993751058209749
and tab is strictly 8 chars.
--
vda

