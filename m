Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUCRQmI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 11:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUCRQmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 11:42:08 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:35982
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262744AbUCRQmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 11:42:05 -0500
Date: Thu, 18 Mar 2004 17:42:53 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-rc1-aa1
Message-ID: <20040318164253.GO2246@dualathlon.random>
References: <20040318022201.GE2113@dualathlon.random> <Pine.LNX.4.44.0403181026250.16728-100000@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403181026250.16728-100000@chimarrao.boston.redhat.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 10:32:58AM -0500, Rik van Riel wrote:
> I don't think wants to use mlock, and I suspect it doesn't

for the short term it's ok, I agree longer term we may want to make them
swappable, but we don't necessairly need to support efficient swapping
for huge vmas (i.e. 10G, if one wants efficient swapping
remap_file_pages shouldn't be used).

Could you tell me how you called the mlock sysctl that Wli talked about?
(Wli mentioned the mlock sysctl in a patch from you) Thanks.
