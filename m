Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422825AbWJQBW6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422825AbWJQBW6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 21:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030208AbWJQBW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 21:22:58 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:57066 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030206AbWJQBW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 21:22:57 -0400
Date: Tue, 17 Oct 2006 02:22:53 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: another broken via pci quirk.
Message-ID: <20061017012253.GA8289@srcf.ucam.org>
References: <20061017005215.GD32681@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061017005215.GD32681@redhat.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 08:52:15PM -0400, Dave Jones wrote:

> We seem to have a habit of running VIA quirks on systems that don't always
> need them. :-/

Hmm. Interesting. I've verified that the two chipsets included both need 
the quirk under certain circumstances, but why is the write killing the 
kernel?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
