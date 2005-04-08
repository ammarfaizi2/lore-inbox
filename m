Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262683AbVDHD7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbVDHD7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 23:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262681AbVDHD7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 23:59:19 -0400
Received: from [81.168.75.8] ([81.168.75.8]:34421 "EHLO henning.makholm.net")
	by vger.kernel.org with ESMTP id S262683AbVDHD4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 23:56:52 -0400
To: <linux-kernel@vger.kernel.org>, <debian-legal@lists.debian.org>,
       <linux-acenic@sunsite.dk>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
References: <MDEHLPKNGKAHNMBLJOLKIEAEDAAB.davids@webmaster.com>
From: Henning Makholm <henning@makholm.net>
Date: Fri, 08 Apr 2005 04:56:50 +0100
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEAEDAAB.davids@webmaster.com> (David
 Schwartz's message of "Thu, 7 Apr 2005 20:05:31 -0700")
Message-ID: <87zmw9dipp.fsf@kreon.lan.henning.makholm.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsit "David Schwartz" <davids@webmaster.com>
[quoting me]

>> No, it is completely wrong to say that the object file is merely an
>> aggregation. The two components are being coupled much more tightly
>> than in the situation that the GPL discribes as "mere aggregation".

>         Would you maintain this position even if the firmware is identical
> across operating systems and the Linux driver is identical across different
> firmware builds for different hardware implementations?

Yes I would. Linking forms a tighter coupling than just placing the
two parts side by side on a filesystem designed for general storage of
byte streams. There is more to say about the situation than the naked
fact that that they are aggreated on the same medium; ergo the
sutiation does not constitute *only* aggregation, and the "mere
aggregation" language of the GPL does not apply.

In particular, the end of GPL #2 does not provide a blanket exception
for all forms of aggregation; it specifically speaks about aggregation
"on a volume of a storage or distribution medium".

>         Note that the issue is not whether the GPL describes this as "mere
> aggregation" because the GPL doesn't get to set its own scope.

The scope of the copyright of the original work includes situation
where part of that original work is being copied (excluding fair use
and other jurisdiction-specific exceptions). In order to do such
copying, you need permission from the copyright holder of the original
work. If all the permission you have is the GPL, the copyihg you are
doing had better fall into the class of copying that the GPL provides
a permission for.

It *is*, therefore, relevant, whether the GPL's special conditions for
works "that in whole or in part contains the Program" apply to the
linked object files.

> The issue is whether the resulting binary is a single work (that is
> derivative of the GPL'd driver) or whether it's two works with a
> license boundary between them.

A reasonable person can disagree about whether the word "work" in GPL
#2(b) is meant to exclude non-trivial aggregations that do not add
creative choice to that already expressed in the components.

However, I don't think a reasonable person can argue that even if 2(b)
had said "byte stream" instead of "work" it would not have been
legally potent to demand GPL-compatible licensing of the firmware as a
condition for the permission to copy the GPL-covered part of the byte
stream.

>         It would not be obviously unreasonable to argue that the NE2000 API
> constitutes a license boundary between the two works, each of which stays on
> its own side of that API.

No, it wouldn't be obviously unreasonable for a license to recognize
such a "license boundary". However, as I see it the GPL happens not to
do this.

>         Lacking clear court guidance, I see it as a threshold issue. One
> primary issue (I think) is to what extent that firmware and the driver have
> been customized for each other. A work that is carefully designed to mesh
> tightly with another work is analogous to a sequel, which is a derivative
> work.

I think the "derivative work" angle is a red herring. I do not think
that either of the two parts that are being linked together (i.e. the
driver and the firmware) are derivates of the other.  The relevant
point is that distribution of the linked _result_ is nevertheless
subject to the condition in GPL #2, which is in general the only
source we have for a permission to distribute a non-verbatim-source
form of the driver.

-- 
Henning Makholm                             "... and that Greek, Thucydides"
