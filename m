Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261436AbUKIHya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261436AbUKIHya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 02:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261422AbUKIHyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 02:54:08 -0500
Received: from nova.rhapsodyk.net ([212.43.230.60]:61900 "EHLO
	nova.rhapsodyk.net") by vger.kernel.org with ESMTP id S261431AbUKIHxp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 02:53:45 -0500
In-Reply-To: <20041108212747.33b6e14a.akpm@osdl.org>
References: <9dda349204110611043e093bca@mail.gmail.com> <20041107024841.402c16ed.akpm@osdl.org> <20041108075934.GA4602@elte.hu> <20041107234225.02c2f9b6.akpm@osdl.org> <20041108224259.GA14506@kroah.com> <20041108212747.33b6e14a.akpm@osdl.org>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <792238A4-3224-11D9-9F1E-000D934362B4@pas-tres.net>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, diffie@blazebox.homeip.net,
       Greg KH <greg@kroah.com>, diffie@gmail.com
From: Olivier Poitrey <olivier@pas-tres.net>
Subject: Re: 2.6.10-rc1-mm3
Date: Tue, 9 Nov 2004 08:53:41 +0100
To: Andrew Morton <akpm@osdl.org>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 nov. 04, at 06:27, Andrew Morton wrote:

> [...] Is there a requirement to support more than 256 legacy ptys?

Yes it is. For big vserver hosting systems for instance, running like
100 vservers per node you can easily hit this limit.

--
Olivier Poitrey

