Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263358AbTETRBz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 13:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263568AbTETRBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 13:01:55 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:21447 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S263358AbTETRBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 13:01:55 -0400
Date: Tue, 20 May 2003 18:18:21 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: Brett <generica@email.com>, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Re: CONFIG_VIDEO_SELECT stole my will to live
Message-ID: <20030520171821.GA31761@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>, Brett <generica@email.com>,
	linux-kernel@vger.kernel.org,
	linux-fbdev-devel@lists.sourceforge.net
References: <20030520155138.GA29450@suse.de> <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0305201752240.28600-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 20, 2003 at 05:55:41PM +0100, James Simmons wrote:

 > > Wasn't the EDID stuff getting backed out anyways ?
 > Only in the VESA driver. Some people did have luck with the BIOS EDID info 
 > so I like to keep the BIOS call in there. 

That code runs way earlier than before we get to do any PCI quirks,
so fixing that one up could be interesting.

		Dave

