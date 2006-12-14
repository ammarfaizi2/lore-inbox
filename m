Return-Path: <linux-kernel-owner+w=401wt.eu-S932901AbWLNUkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbWLNUkr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932898AbWLNUkr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:40:47 -0500
Received: from codepoet.org ([166.70.99.138]:39385 "EHLO codepoet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932901AbWLNUkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:40:46 -0500
Date: Thu, 14 Dec 2006 13:40:46 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] support HDIO_GET_IDENTITY in libata
Message-ID: <20061214204046.GA2607@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org> <200612141930.19797.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0612141150480.5718@woody.osdl.org> <4581AEA0.3040708@garzik.org> <20061214202608.GA2313@codepoet.org> <4581B4A2.8070006@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4581B4A2.8070006@garzik.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Dec 14, 2006 at 03:31:30PM -0500, Jeff Garzik wrote:
> Erik Andersen wrote:
> >+			if (!atapi_enabled && dev->class == ATA_DEV_ATAPI) {
> 
> This seems like an impossible condition?

Hmm, suppose so.  Do you think that simply doing:
	if (dev->class == ATA_DEV_ATAPI) {
here would be sufficient?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
