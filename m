Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263956AbTIIHv1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 03:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263965AbTIIHv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 03:51:27 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:16199 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263956AbTIIHv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 03:51:26 -0400
Date: Tue, 9 Sep 2003 08:50:24 +0100
From: Dave Jones <davej@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dennis Freise <Cataclysm@final-frontier.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: New ATI FireGL driver supports 2.6 kernel
Message-ID: <20030909075023.GA8065@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dennis Freise <Cataclysm@final-frontier.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <001a01c3765b$1f1ad6e0$0419a8c0@firestarter.shnet.org> <20030908225401.GD681@redhat.com> <1063069344.28622.53.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063069344.28622.53.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 02:02:25AM +0100, Alan Cox wrote:

 > > Linking GPL code to binary .o files, and then disabling the
 > > MODULE_LICENSE("GPL") smells pretty fishy to me.
 > 
 > If all the code they include is their own then they could have dual
 > licensed it. If not and they are modifying core kernel code to add hooks
 > for their code they aren't likely to get past the preliminary arguments 
 > about a GPL violation and it being a derivative work.

For one it links in the GPL'd nvidia GART module.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
