Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932161AbWJEQo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161AbWJEQo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 12:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbWJEQo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 12:44:57 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:36586 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932161AbWJEQo4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 12:44:56 -0400
Message-ID: <4525367E.7080101@garzik.org>
Date: Thu, 05 Oct 2006 12:44:46 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: make-bogus-warnings-go-away tree [was: 2.6.18-mm3]
References: <20061003001115.e898b8cb.akpm@osdl.org> <20061005083754.GA1060@elte.hu> <20061005163721.GJ16812@stusta.de>
In-Reply-To: <20061005163721.GJ16812@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> What we'd need would be some -Wno-may-be-used-uninitialized gcc option 
> that turns off the "may be may be used uninitialized" warnings but not 
> the "is used uninitialized" warnings.
> 
> This would:
> - give us a way to silence these warnings
> - allow people to see the warnings if they want to
> - not increase the maintenance overhead


Some of those warnings do indicate real bugs.

	Jeff


