Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161586AbWJaDo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161586AbWJaDo0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 22:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161587AbWJaDo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 22:44:26 -0500
Received: from mail.kroah.org ([69.55.234.183]:14978 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161586AbWJaDoZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 22:44:25 -0500
Date: Mon, 30 Oct 2006 19:43:42 -0800
From: Greg KH <greg@kroah.com>
To: Sylvain Bertrand <sylvain.bertrand@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Chris Wedgwood <cw@f00f.org>,
       "bugme-daemon@kernel-bugs.osdl.org" 
	<bugme-daemon@bugzilla.kernel.org>
Subject: Re: [Bugme-new] [Bug 7437] New: VIA VT8233 seems to suffer from the via latency quirk
Message-ID: <20061031034342.GC11944@kroah.com>
References: <200610310020.k9V0KGQK003237@fire-2.osdl.org> <20061030163458.4fb8cee1.akpm@osdl.org> <d512a4f30610301703r68dfa848s116475b68435f136@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d512a4f30610301703r68dfa848s116475b68435f136@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 02:03:02AM +0100, Sylvain Bertrand wrote:
> Unfortunately, this has always happened since kernel 2.4 from years
> back, even with USB1 devices and I had to drop software raid 0.
> As far as I understand the quirk code, it's not enabled for the VT8233
> southbridge.
> I can add the PCI ID of this VT8233 for this quirk code, if it's
> compatible, and do some crash tests. Crashes are usually easy to
> produce and not hardware destructive since I got plenty of them. But
> you may want to proceed in another way.

That would be the best way to proceed.  If you add your device ids to
the quirk, does the machine work properly afterward?

thanks,

greg k-h
