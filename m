Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTDXV0D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 17:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264483AbTDXVYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 17:24:45 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:22920 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264477AbTDXVYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 17:24:36 -0400
Date: Thu, 24 Apr 2003 22:36:32 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Werner Almesberger <wa@almesberger.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       linux-kernel <linux-kernel@vger.kernel.org>, pat@suwalski.net
Subject: Re: [Bug 623] New: Volume not remembered.
Message-ID: <20030424213632.GK30082@mail.jlokier.co.uk>
References: <20030423191427.D3557@almesberger.net> <1570840000.1051136330@flay> <20030424001134.GD26806@mail.jlokier.co.uk> <20030423214332.H3557@almesberger.net> <20030424011137.GA27195@mail.jlokier.co.uk> <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030424103858.M3557@almesberger.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Werner Almesberger wrote:
> ALSA (Advanced Linux Sound Architecture) is now the preferred
> architecture for sound support, instead of the older OSS (Open
> Sound System). Note that all volume settings default to zero
> in ALSA, so user space needs to explicitly increase the volume
> before any sound can be heard.

I'm not sure whether that's actually correct, but as long as there's a
mixture of ALSA and non-ALSA drivers in 2.6, they really ought to
have the same behaviour in this regard.

I.e. if silence is the load-time setting, the OSS drivers and other
non-ALSA sound drivers should be changed to do that as well.

-- Jamie
