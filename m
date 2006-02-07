Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWBGRUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWBGRUe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 12:20:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751013AbWBGRUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 12:20:33 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:7836 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1750720AbWBGRUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 12:20:33 -0500
Date: Tue, 7 Feb 2006 17:20:24 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Michael_E_Brown@Dell.com
Cc: akpm@osdl.org, Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Message-ID: <20060207172024.GA6431@srcf.ucam.org>
References: <35C9A9D68AB3FA4AB63692802656D9EC9277C0@ausx3mps303.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35C9A9D68AB3FA4AB63692802656D9EC9277C0@ausx3mps303.aus.amer.dell.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006 at 10:34:31AM -0600, Michael_E_Brown@Dell.com wrote:
> You can get and set laptop brighness on Dell with the proper SMI call.

Oh, heavens. Could you people (and here I include pretty much everyone 
who manufactures laptops) please (please!) just implement the ACPI video 
extension? We're going to end up having to ship a 200K library for 
each and every laptop manufacturer who's decided to implement basic 
functionality in a proprietary manner, and it's going to make me cry.

(Which SMI do I need for brightness control? The libsmbios docs seem to 
be remarkably quiet on what functionality is actually available, and I'm 
not keen on calling things randomly :))

-- 
Matthew Garrett | mjg59@srcf.ucam.org
