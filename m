Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262792AbULQMU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbULQMU2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 07:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbULQMU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 07:20:28 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:5068 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262792AbULQMTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 07:19:18 -0500
Date: Fri, 17 Dec 2004 12:18:52 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.10-rc3-mm1
In-Reply-To: <20041217120054.GT771@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0412171209490.9510-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2004, William Lee Irwin III wrote:
> William Lee Irwin III <wli@holomorphy.com> wrote:
> >> The odd userspace programs failing are far more disturbing. They
> >> suggest COW or something of similar gravity is broken on x86-64
> >> by some new patch. The ioremap/pageattr issues are merely some
> >> shutdown-time oops, which is rather minor in comparison, although
> >> reported far more verbosely.
> 
> On Thu, Dec 16, 2004 at 11:55:05PM -0800, Andrew Morton wrote:
> > Oh, I missed that.  Did you apply the ioctl fix?
> 
> Seems unlikely to be related, but I'll try it.

Odd userspace programs failing?  Andrew slipped Christoph Lameter's
page scalability patches, including the various bugs we pointed out,
into 2.6.10-rc3-mm1.  I've not seen such failures with those patches
(on i386 with < 4GB), but that's where I'd be looking for causes.

Hugh

