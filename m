Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTA1ACR>; Mon, 27 Jan 2003 19:02:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTA1ACR>; Mon, 27 Jan 2003 19:02:17 -0500
Received: from holomorphy.com ([66.224.33.161]:28839 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264730AbTA1ACR>;
	Mon, 27 Jan 2003 19:02:17 -0500
Date: Mon, 27 Jan 2003 16:10:24 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org
Subject: Re: kexec reboot code buffer
Message-ID: <20030128001024.GD780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org
References: <3E31AC58.2020802@us.ibm.com> <m1znppco1w.fsf@frodo.biederman.org> <3E35AAE4.10204@us.ibm.com> <203100000.1043705004@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <203100000.1043705004@flay>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2003 at 02:03:24PM -0800, Martin J. Bligh wrote:
> We talked about creating a new zone specifically for DMA32 (ie <4Gb)
> for other reasons, but it's not there as yet. As Dave mentioned,
> ZONE_NORMAL should be sufficient, though if you need it physically
> contiguous, that might be a problem.

Slapping down the new zone type is trivial and has no obvious negative
consequences. There's no clear reason why it's not already been done.

-- wli
