Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264398AbUAAPlF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 10:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbUAAPlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 10:41:04 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:13834 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S264398AbUAAPlC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 10:41:02 -0500
Date: Thu, 1 Jan 2004 16:52:38 +0100
To: Kristof Pelckmans <kristof.pelckmans@antwerpen.be>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
Subject: Re: 2.6.0 framebuffer Matrox
Message-ID: <20040101155238.GA27217@hh.idb.hist.no>
References: <20040101122313.qjx7h3k8g4s4484s@albert.homedns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101122313.qjx7h3k8g4s4484s@albert.homedns.org>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 12:23:13PM +0100, Kristof Pelckmans wrote:
> Hi,
> 
> I am trying to get the matroxfb working on the second head of the G450, but I
> get the impression that the second head is a duplication of the first :

I have a G550.  Two framebuffers works fine, but the boot default is to
show /dev/fb0 on both heads.  I guess this is because you never know
what connector people with a single monitor uses.  (Unnecessary,
because the bios only activates one output...)

Get the matroxset utility, it is used to set up which framebuffer
(fb0 or fb1) is displayed on what connector.

X and everything works fine once this is set up right.

You can do early checking by catting two different files into
/dev/fb0 and /dev/fb1, you'll see different "garbage" appear
on either screen.

Helge Hafting
