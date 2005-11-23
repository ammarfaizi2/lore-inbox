Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750846AbVKWOnH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbVKWOnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 09:43:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750849AbVKWOnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 09:43:07 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:26544 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750847AbVKWOnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 09:43:06 -0500
Subject: Re: Use enum to declare errno values
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: moreau francis <francis_moreau2000@yahoo.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <200511231631.12365.vda@ilport.com.ua>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com>
	 <200511231631.12365.vda@ilport.com.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 23 Nov 2005 15:15:10 +0000
Message-Id: <1132758910.7268.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-11-23 at 16:31 +0200, Denis Vlasenko wrote:
> Enums are really nice substitute for integer constants instead of #defines.
> Enums obey scope rules, #defines do not.
> 
> However enums are not widely used because of
> 1. tradition and style
> 2. awkward syntax required:   enum { ABC = 123 };

The SATA layer uses enum for constants and while it was a bit of change
in style when I met it, it does seem to work just as well

