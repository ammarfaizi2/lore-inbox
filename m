Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTFGWbB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 18:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263922AbTFGWbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 18:31:01 -0400
Received: from holomorphy.com ([66.224.33.161]:6857 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263865AbTFGWbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 18:31:00 -0400
Date: Sat, 7 Jun 2003 15:43:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Maximum swap space?
Message-ID: <20030607224312.GJ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <ltptlqb72n.fsf@colina.demon.co.uk> <33435.4.64.196.31.1055008200.squirrel@www.osdl.org> <bbtmaq$r03$1@cesium.transmeta.com> <20030607214950.GI8978@holomorphy.com> <3EE264C5.6060703@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EE264C5.6060703@zytor.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> The 2GB limit is 100% userspace; distros are already shipping the
>> mkswap(8) fixes (both RH & UL anyway).

On Sat, Jun 07, 2003 at 03:18:45PM -0700, H. Peter Anvin wrote:
> Presumably it means they have defined a new swap format and have changed 
> swapon(8) as well.  This should be rolled back into util-linux if they 
> aren't already.

The swap format (or at least the header) doesn't appear to depend on
byte offsets that I can tell, so I don't see any need for it to change.
I'm not entirely sure what they've done for swapon(8) or mkswap(8),
though I could probably bang out an equivalent or fish out their
patches if pressed.


-- wli
