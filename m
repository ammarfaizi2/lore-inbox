Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVAXXYq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVAXXYq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 18:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVAXXYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 18:24:00 -0500
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:45121 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S261672AbVAXXSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 18:18:21 -0500
Date: Tue, 25 Jan 2005 00:18:18 +0100 (CET)
From: Lukasz Trabinski <lukasz@oceanic.wsisiz.edu.pl>
To: chas3@users.sourceforge.net
Cc: Mike Westall <westall@cs.clemson.edu>,
       linux-atm-general@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: [Linux-ATM-General] Kernel 2.6.10 and 2.4.29 Oops fore200e (fwd)
In-Reply-To: <200501242238.j0OMcru4017742@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.61L.0501250009240.9051@oceanic.wsisiz.edu.pl>
References: <200501242238.j0OMcru4017742@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2005, chas williams - CONTRACTOR wrote:

> the author sent me the latest version of the driver and i
> got it applied.  the driver does has some useful changes
> along with this broken change.  i suggest udelay() since
> it preserves the author's original intent.

Ok, i have just put udelay() function to the driver. If router will not 
crash after 5-6 days, it mean that driver works fine. I will inform about
it. Generally problems has stareted (frequently crashes) when we puted to 
them more atm interfaces/VCs and router started forward more traffic and
operated with two additional full bgp table.

-- 
£T
