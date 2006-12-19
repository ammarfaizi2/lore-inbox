Return-Path: <linux-kernel-owner+w=401wt.eu-S932924AbWLSUDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924AbWLSUDZ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 15:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932925AbWLSUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 15:03:25 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60726 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932924AbWLSUDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 15:03:24 -0500
Subject: Re: Changes to sysfs PM layer break userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, gregkh@suse.de
In-Reply-To: <20061219194410.GA14121@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
	 <1166556889.3365.1269.camel@laptopd505.fenrus.org>
	 <20061219194410.GA14121@srcf.ucam.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 19 Dec 2006 21:03:21 +0100
Message-Id: <1166558602.3365.1271.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 19:44 +0000, Matthew Garrett wrote:
> On Tue, Dec 19, 2006 at 08:34:48PM +0100, Arjan van de Ven wrote:
> 
> > which userspace is using this btw?
> 
> Ubuntu uses it to disable wireless hardware under certain circumstances. 
> I believe that Suse's powernowd uses it to power down wired ethernet 
> hardware when it's not in use.

humm shouldn't the driver do this when the interface is brought down?
sounds like you're playing with fire to do this behind the drivers'
back....

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

