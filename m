Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261697AbTCGS1c>; Fri, 7 Mar 2003 13:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261675AbTCGS1c>; Fri, 7 Mar 2003 13:27:32 -0500
Received: from holomorphy.com ([66.224.33.161]:938 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S261697AbTCGS1a>;
	Fri, 7 Mar 2003 13:27:30 -0500
Date: Fri, 7 Mar 2003 10:36:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Minutes from LSE Call March 7
Message-ID: <20030307183647.GF465@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Hanna Linder <hannal@us.ibm.com>, lse-tech@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <17720000.1047062069@w-hlinder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17720000.1047062069@w-hlinder>
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 10:34:29AM -0800, Hanna Linder wrote:
> Bill is using some simplified heuristics to search
> for pages to fault in. Turns out those heuristics 
> suck so he needs to go in and do a different set.
> The ones originally done in Hugh's patch did something
> in the order of scanning acros an entire vma looking
> for pte's pointing to a particular page. It didnt
> have any alignment restrictions. Bill does have
> alignment restrictions and Hugh's solution would
> break down pretty quickly (kernel compiles swapping).

The bit about Hugh's heuristics is backward; the heuristics he used
for 2.4.x were very effective. It's my homegrown heuristics that are
breaking down very quickly wrt. performance and fragmentation.


-- wli
