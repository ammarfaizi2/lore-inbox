Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265106AbTLCSdY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 13:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbTLCSdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 13:33:23 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:49418 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S265106AbTLCSdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 13:33:22 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: Linux 2.4 future
Date: 3 Dec 2003 18:22:12 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bql9kk$iq1$1@gatekeeper.tmr.com>
References: <20031202135423.GB13388@conectiva.com.br> <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>
X-Trace: gatekeeper.tmr.com 1070475732 19265 192.168.12.62 (3 Dec 2003 18:22:12 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0312021508470.21855@moje.vabo.cz>,
Tomas Konir  <moje@vabo.cz> wrote:
| On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
| 
| > Em Tue, Dec 02, 2003 at 02:38:54PM -0500, Tomas Konir escreveu:
| > > On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
| > > 
| > > > Em Tue, Dec 02, 2003 at 02:06:34PM -0500, Tomas Konir escreveu:
| > > > > On Tue, 2 Dec 2003, Arnaldo Carvalho de Melo wrote:
| > > > > 
| > > > > > Em Tue, Dec 02, 2003 at 12:54:36PM +0100, Ionut Georgescu escreveu:
| > > > > > > I can only second that. We've been using XFS here since the days of
| > > > > > > 2.4.0-testxx and the only problems we've had were sitting between the
| > > > > > > chair and the keyboard.
| > > > > > 
| > > > > > So if there is no problems at all using it as a patch why add this to a
| > > > > > kernel that is phasing out?
| > > > > 
| > > > > Because me and others are wasting our time when merging xfs with other 
| > > > > patches such as grsecurity. XFS in kernel can save our time. The question 
| > > > > is, that if JFS and other FS's are in kernel, why not XFS ?
| > > > 
| > > > Why not ReiserFS4? Or DRBD? Or... :-)
| > > 
| > > ReiserFS4 is stable ? very new information for me.

Therein is a fair question. There are a lot more people using XFS than
JFS, or at least if people are using JFS they are not talking about it
much. And XFS has been around and stable for a long time, probably
longer than stable JFS (and some would argue Reiser ;-). I don't think
new FS should be added indefinitely, but since XFS has seniority, a
larger user base than some FS in the kernel, neither of which will ever
be argued again for another FS, it seems possible to add XFS without
setting foot on some hypothetical slippery slope.

As a stability issue, since people are using XFS, it would probably be
better to have it in than as a patch added and possibly modified by each
vendor.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
