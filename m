Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264727AbSJ3QSn>; Wed, 30 Oct 2002 11:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264728AbSJ3QSn>; Wed, 30 Oct 2002 11:18:43 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:48399 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S264727AbSJ3QSm>;
	Wed, 30 Oct 2002 11:18:42 -0500
Date: Wed, 30 Oct 2002 08:22:22 -0800
From: Greg KH <greg@kroah.com>
To: Burton Windle <bwindle@fint.org>
Cc: linux-kernel@vger.kernel.org, johannes@erdfelt.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [2.5.44] USB Devices register twice
Message-ID: <20021030162221.GA1040@kroah.com>
References: <Pine.LNX.4.43.0210301033480.317-100000@morpheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.43.0210301033480.317-100000@morpheus>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 10:41:43AM -0500, Burton Windle wrote:
> As of 2.5.44 (and in 44-bk2), if I unplug a USB device, then plug it in
> again, it registers itself twice. This does not happen in 2.5.43.

Thanks for testing again with bk2, but I'm waiting for the fixed
reference counting logic from Pat Mochel to go into the tree before I
dig into this one.

Now if we had that Bugzilla instance that the IBM people mentioned a
while ago working, this report could be entered into that...

thanks for your patience,

greg k-h
