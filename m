Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264009AbTJFQRq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTJFQRq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 12:17:46 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:56523 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S264009AbTJFQRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 12:17:38 -0400
Message-ID: <20031006161733.24441.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Mon, 06 Oct 2003 11:17:33 -0500
Subject: Circular Convolution scheduler
X-Originating-Ip: 172.132.11.23
X-Originating-Server: ws3-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Though the mechanism is doubtless familiar
to signal processing and graphics implementers,
it's probably not thought of much in a
process scheduling contex (although there was
the Evolution Scheduler of a few years ago,
whose implementer may have had something like
circular convolution in mind). It just seems to me
(intuition) that the concept of what circular convolution does is akin to what we've been
feeling around for with these ad hoc heuristic
tweaks to the scheduler to adjust for interactivity
and batch behavior, searching for an incremental self-adjusting mechanism that favors interactivity
on demand.

I've never implemented a circular convolver in
any context, so I was wondering if anyone who
has thinks scheduler prioritization would be
simpler if implemented directly as a circular convolution.

(If nothing else, it seems to me that the abstract model of what the schedule prioritizer is doing
would be more coherent than it is with ad hoc
code. This perhaps reduces the risk of unexpected side-effects of incremental tweaks to the scheduler. The behavior of an optimizer that implements
an integer approximation of a known mathematical transform when you change its inputs is fairly predictable.)

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
__________________________________________________________
Sign-up for your own personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

