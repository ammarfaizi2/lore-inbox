Return-Path: <linux-kernel-owner+w=401wt.eu-S932913AbWLSTfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932913AbWLSTfA (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:35:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932917AbWLSTfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:35:00 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41594 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932913AbWLSTe7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:34:59 -0500
Subject: Re: Changes to sysfs PM layer break userspace
From: Arjan van de Ven <arjan@infradead.org>
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, gregkh@suse.de
In-Reply-To: <20061219185223.GA13256@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 19 Dec 2006 20:34:48 +0100
Message-Id: <1166556889.3365.1269.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-19 at 18:52 +0000, Matthew Garrett wrote:
> Commit 047bda36150d11422b2c7bacca1df324c909c0b3 broke userspace. 
> Previously, /sys/bus/pci/devices/foo/power/state could have values 
> echoed into it for triggering suspend/resume calls in the driver. The 
> breakage is handily mentioned in the comment:
> 
> "Devices with bus.suspend_late(), or bus.resume_early() methods fail 
> this operation; those methods couldn't be called."
> 
> but there's no mention of what previously working code is supposed to do 
> now. That's the second time in the past year or so that this interface 
> has been broken - can we have it working again, please, especially as 
> there doesn't appear to be an alternative yet?


which userspace is using this btw?


