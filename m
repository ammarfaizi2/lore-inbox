Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263622AbTIHWzO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 18:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263716AbTIHWzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 18:55:14 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:35608 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263622AbTIHWzK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 18:55:10 -0400
Date: Mon, 8 Sep 2003 23:54:03 +0100
From: Dave Jones <davej@redhat.com>
To: Dennis Freise <Cataclysm@final-frontier.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New ATI FireGL driver supports 2.6 kernel
Message-ID: <20030908225401.GD681@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Dennis Freise <Cataclysm@final-frontier.org>,
	linux-kernel@vger.kernel.org
References: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 12:47:02AM +0200, Dennis Freise wrote:
 > > isn't the 2.5 AGP GPL licensed? How can ATI then include it in a bin
 > > only module ? ....
 > 
 > The ATI drivers are NOT binary-only!

http://www.codemonkey.org.uk/projects/agp/binary.shtml

 > agpgart (modified by ATI, I suppose) is
 > included in form of sourcecode, being compiled on installation. Dunno what
 > else could violate GPL :)

Linking GPL code to binary .o files, and then disabling the
MODULE_LICENSE("GPL") smells pretty fishy to me.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
