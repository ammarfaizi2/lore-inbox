Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261492AbSLIBkj>; Sun, 8 Dec 2002 20:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSLIBki>; Sun, 8 Dec 2002 20:40:38 -0500
Received: from holomorphy.com ([66.224.33.161]:41110 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261492AbSLIBki>;
	Sun, 8 Dec 2002 20:40:38 -0500
Date: Sun, 8 Dec 2002 17:47:57 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: qlogic isp1020 broken in 2.5.50
Message-ID: <20021209014757.GA9882@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <56340000.1039398073@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56340000.1039398073@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 08, 2002 at 05:41:13PM -0800, Martin J. Bligh wrote:
> Anyone working on this, or know how to backout whatever broke it?
> Seem to work fine in 47 (unless just the warning is new, and it's
> been broken all along).

Hmm? It's oopsing in isp1020_intr_handler() when I try to mount > 1
filesystem over here. Seems to have gotten rather consistent lately
(independent of kernel), but / is on the same thing and it does fine.


Bill
