Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269169AbTGORRz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 13:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269166AbTGORRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 13:17:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17351
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S269169AbTGORRx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 13:17:53 -0400
Subject: Re: 2.6.0-test1-ac1 Matrox Compile Error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: James Simmons <jsimmons@infradead.org>, dank@reflexsecurity.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030715171354.GA12899@suse.de>
References: <bf19d5$d00$1@main.gmane.org>
	 <Pine.LNX.4.44.0307151740040.7091-100000@phoenix.infradead.org>
	 <20030715171354.GA12899@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058290204.3857.51.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Jul 2003 18:30:05 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-15 at 18:13, Dave Jones wrote:
> On Tue, Jul 15, 2003 at 05:40:52PM +0100, James Simmons wrote:
> 
>  > > you'll need to build VT support.
>  > Ug. That is wrong. Fbdev driver are independent of the console layer.
> 
> Regardless, the number of people falling over this issue is still
> somewhere in the region of "silly".
> The only people who would want to turn off VT support are likely to
> be embedded folks, so why not move this under CONFIG_EMBEDDED ?
> and force it to '=y' for everyone else ?

Seconded  - care to send me a diff for -ac2 8)

