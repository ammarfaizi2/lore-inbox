Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758214AbWK0Nv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758214AbWK0Nv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 08:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758218AbWK0Nv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 08:51:57 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:43919 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1758216AbWK0Nv5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 08:51:57 -0500
Date: Mon, 27 Nov 2006 13:51:37 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Robert Hancock <hancockr@shaw.ca>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch] PM: suspend/resume debugging should depend on SOFTWARE_SUSPEND
Message-ID: <20061127135136.GA13597@srcf.ucam.org>
References: <fa.U3NcOE+DHLOUMSq6HkaGglGl7hQ@ifi.uio.no> <fa.bo0iOgKqELDD50VEZpxeUpzPsMg@ifi.uio.no> <45693E25.9010504@shaw.ca> <200611261113.12826.rjw@sisk.pl> <4569F957.4090100@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4569F957.4090100@shaw.ca>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 02:30:15PM -0600, Robert Hancock wrote:

> Yes, it's x86-64, with whatever version of vbetool comes with Fedora Core 5.

Ought to be fixed in the next release of vbetool. The x86emu code in the 
current version is a touch broken, and nvidia bioses seem to trip it 
quite well.

