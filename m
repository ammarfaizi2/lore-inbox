Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284138AbRLAQUO>; Sat, 1 Dec 2001 11:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284142AbRLAQUE>; Sat, 1 Dec 2001 11:20:04 -0500
Received: from ns.suse.de ([213.95.15.193]:18955 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284138AbRLAQTu>;
	Sat, 1 Dec 2001 11:19:50 -0500
Date: Sat, 1 Dec 2001 17:19:26 +0100
From: Andi Kleen <ak@suse.de>
To: berthiaume_wayne@emc.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Multicast Broadcast
Message-ID: <20011201171926.A22256@wotan.suse.de>
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB42@corpusmx1.us.dg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93F527C91A6ED411AFE10050040665D00241AB42@corpusmx1.us.dg.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2001 at 04:12:58PM -0500, berthiaume_wayne@emc.com wrote:
> 	Andi, it appears that JVM doesn't support the ip_mreqn struct that
> would allow us to use imr_ifindex but supports only the older ip_mreq struct
> as the optval. Any other suggestions.

ip_mreqn is the only way I can think off. My suggestion is to fix the JVM
or use JNI.


-Andi
