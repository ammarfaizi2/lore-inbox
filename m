Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269100AbTGORAj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268715AbTGORAj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:00:39 -0400
Received: from genius.impure.org.uk ([195.82.120.210]:36764 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S269100AbTGOQ7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 12:59:18 -0400
Date: Tue, 15 Jul 2003 18:13:54 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: James Simmons <jsimmons@infradead.org>
Cc: dank@reflexsecurity.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
Message-ID: <20030715171354.GA12899@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	James Simmons <jsimmons@infradead.org>, dank@reflexsecurity.com,
	linux-kernel@vger.kernel.org
References: <bf19d5$d00$1@main.gmane.org> <Pine.LNX.4.44.0307151740040.7091-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307151740040.7091-100000@phoenix.infradead.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 05:40:52PM +0100, James Simmons wrote:

 > > you'll need to build VT support.
 > Ug. That is wrong. Fbdev driver are independent of the console layer.

Regardless, the number of people falling over this issue is still
somewhere in the region of "silly".
The only people who would want to turn off VT support are likely to
be embedded folks, so why not move this under CONFIG_EMBEDDED ?
and force it to '=y' for everyone else ?

		Dave

