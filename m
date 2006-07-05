Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWGEGtK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWGEGtK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 02:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbWGEGtK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 02:49:10 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:4972 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751223AbWGEGtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 02:49:08 -0400
From: David Brownell <david-b@pacbell.net>
To: "Miles Lane" <miles.lane@gmail.com>
Subject: Re: 2.6.17-mm5 -- netconsole failed to send full trace
Date: Tue, 4 Jul 2006 23:49:04 -0700
User-Agent: KMail/1.7.1
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <a44ae5cd0607030131x745b3106ydd2a4ca086cdf401@mail.gmail.com> <20060703121717.b36ef57e.akpm@osdl.org> <a44ae5cd0607042222w6a370b70ka2d75fab926a28be@mail.gmail.com>
In-Reply-To: <a44ae5cd0607042222w6a370b70ka2d75fab926a28be@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607042349.05509.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 10:22 pm, Miles Lane wrote:

> > So we have a use-after-free in tasklet_action(), as a consequence of
> > unplugging a USB ethernet adapter.
> 
> So far, all the kernels have crashed (back to Ubuntu's 2.6.15). 

Erm, exactly which USB ethernet adapter?  That would seem to be a
critical bit of info that's somehow been omitted...

If it's the rtl8150 driver, that would be Petko's ...

