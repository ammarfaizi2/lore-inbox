Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266394AbUFQG5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266394AbUFQG5K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 02:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266392AbUFQG5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 02:57:09 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:29579 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266393AbUFQG41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 02:56:27 -0400
Date: Thu, 17 Jun 2004 08:56:07 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Linux 2.6.7
Message-ID: <20040617065607.GA11999@louise.pinerecords.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org> <20040616111329.GA1571@louise.pinerecords.com> <20040616121850.GO12308@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616121850.GO12308@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun-16 2004, Wed, 13:18 +0100
viro@parcelfarce.linux.theplanet.co.uk <viro@parcelfarce.linux.theplanet.co.uk> wrote:

> > 2.6.7's airo.ko (unlike 2.6.6's) won't allow the user to set
> > ESSID via "echo myessid >/proc/driver/aironet/ethX/SSID".
> > 
> > Changes like this shouldn't probably be made in the middle
> > of a stable series.
> 
> Changes like this are called bugs.  The thing is, original variant of
> function (actually, both read and write) was also buggy and trivially
> exploitable, so fixing it was needed.  Fscking it up was not, obviously.

Sure, I just assumed somebody had done this on purpose.

> Fix follows; see if it works for you.

Works for me, thanks.

-- 
Tomas Szepe <szepe@pinerecords.com>
