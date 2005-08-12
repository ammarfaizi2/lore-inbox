Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbVHLFpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbVHLFpm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 01:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932348AbVHLFpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 01:45:42 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:64751 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932320AbVHLFpl convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 01:45:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QZzhsrzdoXsRpX2S5ck8Okkextlc1xwodu95pepFRpzUtWKEG3GwZyNWkFfBiyCVcQYRkQeVvf7FgPRiyMGJQyGCPWhroiC/9nJ1VHuKU0yNblm2E8nSyfNkWfqllqFfowKeXEKGswt1VF0P6XRaJVo7pGTNIEUPMH/5LY+Uczw=
Message-ID: <4807377b05081122456418d62c@mail.gmail.com>
Date: Thu, 11 Aug 2005 22:45:40 -0700
From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
To: "Stephen D. Williams" <sdw@lig.net>
Subject: Re: Soft lockup in e100 driver ?
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <42FC1356.7080708@lig.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050809133647.GK22165@mea-ext.zmailer.org>
	 <1123604182.15991.40.camel@c-67-188-6-232.hsd1.ca.comcast.net>
	 <20050809163632.GQ22165@mea-ext.zmailer.org>
	 <42FA9C02.3030406@lig.net> <42FA9CAD.7030607@lig.net>
	 <20050811073946.GT22165@mea-ext.zmailer.org>
	 <42FC1356.7080708@lig.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/05, Stephen D. Williams <sdw@lig.net> wrote:
> The chipset is an Intel 8x0 something.  Unfortunately, there is a
> heatsink semi-permanently installed over everything.  Is there a /proc
> pseudofile that will give me good identifying chipset info to report here?

you can show the chipset details with lspci
lspci -n will show device IDs and revision ids

interesting failure case on the e100, I haven't a clue whats going on.

netdev @ vger might be a good place to continue the discussion abut e100 issues.
