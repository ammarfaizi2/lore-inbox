Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932698AbVIHPot@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbVIHPot (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:44:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVIHPot
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:44:49 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:51048
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932698AbVIHPos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:44:48 -0400
Message-Id: <432078D102000078000244D5@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:45:53 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Christoph Hellwig" <hch@infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] add stricmp
References: <43206F420200007800024455@emea1-mh.id2.novell.com>  <20050908151754.GB11067@infradead.org>  <432074B302000078000244A3@emea1-mh.id2.novell.com> <1126195489.19834.39.camel@localhost.localdomain>
In-Reply-To: <1126195489.19834.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The only general, usable strnicmp safe for general kernel use would be
a
>full all singing all dancing UTF-8 symbol aware arbitary locale
>implementation. And that we *definitely* do not want in kernel.

Then you'd want to immediately get rid of the mentioned, pre-exisiting
strnicmp().

Jan
