Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316223AbSHFVN5>; Tue, 6 Aug 2002 17:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316235AbSHFVN5>; Tue, 6 Aug 2002 17:13:57 -0400
Received: from adsl-64-166-241-227.dsl.snfc21.pacbell.net ([64.166.241.227]:1467
	"EHLO www.hockin.org") by vger.kernel.org with ESMTP
	id <S316223AbSHFVNy>; Tue, 6 Aug 2002 17:13:54 -0400
From: Tim Hockin <thockin@hockin.org>
Message-Id: <200208062115.g76LFga14394@www.hockin.org>
Subject: Re: ethtool documentation
To: root@chaos.analogic.com
Date: Tue, 6 Aug 2002 14:15:41 -0700 (PDT)
Cc: cfriesen@nortelnetworks.com (Chris Friesen),
       rddunlap@osdl.org (Randy.Dunlap), linux-kernel@vger.kernel.org,
       abraham@2d3d.co.za
In-Reply-To: <Pine.LNX.3.95.1020806155358.25303A-100000@chaos.analogic.com> from "Richard B. Johnson" at Aug 06, 2002 04:03:46 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you ever sell a controller that contains an address that was
> not allocated to the 'producer', somebody is going to get very
> angry. This means, to me, that if you ever write a new MAC address
> to that card/board, you had better throw it away when you are done.

As a developer of integrated systems, it is imperative the we be able to
re-program EEPROMs and MAC addresses.  Cobalt systems all have Cobalt as
the MFR section of the MAC address.  Sun Systems all have Sun.  (insert pokes
about whether Cobalt is Sun here...)

> It's easier to make sure that the MAC address doesn't get changed.
> You still "screw the comittee" locally, but you don't modify the
> hardware.

Other things get stored in the EEPROM - for example, Wake-on-Lan options.
Just to name one.
