Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267961AbUHEUkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267961AbUHEUkz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUHEUha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:37:30 -0400
Received: from main.gmane.org ([80.91.224.249]:25251 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267829AbUHEUgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:36:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: Firewire hard drives
Date: Thu, 05 Aug 2004 22:36:35 +0200
Message-ID: <yw1xu0vhfhkc.fsf@kth.se>
References: <200408051612.36445.caleb_gibbs@sbcglobal.net> <16658.38447.591862.21787@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:aTAh7smru98hV6g5REnFbHgLOY0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"John Stoffel" <stoffel@lucent.com> writes:

> Caleb> Has anyone had any luck getting there external firewire hard
> Caleb> drive to mount?  my laptop is running suse9.0 and detects the
> Caleb> firewire hub and works great with my usb devices but when I
> Caleb> plug in the firewire hdd it boots the device but I can`t mount
> Caleb> it.
>
> I've been having problems too with these devices.  I've been trying
> with a dual interface USB2.0/Firewire box with a Prolific Technology
> chipset.  This is with 2.6.[678]-* kernels of various types.  I can do
> a mkfs under either USB2 or Firewire connections (both ports are on
> the same Adaptec PCI card) but the firewire sides bombs out much
> quicker.  

Try giving the sbp2 module the option serialize_io=1.  It helped get
my firewire case running.

-- 
Måns Rullgård
mru@kth.se

