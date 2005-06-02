Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261489AbVFBXBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261489AbVFBXBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVFBXAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:00:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261438AbVFBW6a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 18:58:30 -0400
Date: Thu, 2 Jun 2005 18:58:05 -0400
From: Alan Cox <alan@redhat.com>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
       rmk+serial@arm.linux.org.uk, alan@redhat.com
Subject: Re: Moxa multi serial driver doesn't pass received chars up
Message-ID: <20050602225805.GB9628@devserv.devel.redhat.com>
References: <200506021220.47138.vda@ilport.com.ua> <200506021554.07316.vda@ilport.com.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506021554.07316.vda@ilport.com.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 03:54:07PM +0300, Denis Vlasenko wrote:
> I am cooking a patch which will use
> tty_insert_flip_char(tty, ch, flag);

Cool. Thats the right way for it to work

