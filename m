Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbTKYIrl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Nov 2003 03:47:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbTKYIrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Nov 2003 03:47:41 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8201
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S262114AbTKYIrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Nov 2003 03:47:40 -0500
Date: Tue, 25 Nov 2003 00:47:36 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: OOps! was: 2.6.0-test9-mm5
Message-ID: <20031125084736.GA1357@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20031124235807.GA1586@mis-mike-wstn.matchmail.com> <20031125003658.GA1342@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311242013270.1859@montezuma.fsmlabs.com> <20031125051018.GA1331@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311250033170.4230@montezuma.fsmlabs.com> <20031125054709.GC1331@mis-mike-wstn.matchmail.com> <Pine.LNX.4.58.0311250053410.4230@montezuma.fsmlabs.com> <20031125063602.GA1329@mis-mike-wstn.matchmail.com> <20031125075421.GA1342@mis-mike-wstn.matchmail.com> <20031125080512.GA1356@mis-mike-wstn.matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031125080512.GA1356@mis-mike-wstn.matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 25, 2003 at 12:05:12AM -0800, Mike Fedyk wrote:
> Trying the last one...

pnp-fix-1

That's the one!  Revert it, and no more oops. :)

00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400 AGP] Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
00:0c.0 Unknown mass storage controller: Promise Technology, Inc. 20269 (rev 02)
00:0e.0 RAID bus controller: CMD Technology Inc PCI0680 (rev 02)
00:0f.0 VGA compatible controller: S3 Inc. 86c325 [ViRGE] (rev 06)
00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80)
00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06)
00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 [Rhine-II] (rev 74)

Linux mis-mike-wstn 2.6.0-test9-mm5-revpnp1 #7 SMP Tue Nov 25 00:08:46 PST 2003 i686 GNU/Linux
