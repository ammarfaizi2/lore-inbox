Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267889AbTGHW52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267890AbTGHW52
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:57:28 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:26847 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S267889AbTGHW50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:57:26 -0400
Message-ID: <20030708231157.7322.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Tue, 08 Jul 2003 18:11:56 -0500
Subject: Re: PTY DOS vulnerability?
X-Originating-Ip: 172.147.196.167
X-Originating-Server: ws3-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Seems to me that a pty ulimit and making
sure that root can always access an unused
pty on demand are separate issues.

The ulimit is the same issue that it is for
open files, disk quota, aggregate per-user
memory utilization, etc, maintaining the
"multi-user" aspect of system usability.

Making sure that root has the tools to do
what is needed in a pty resource exhaustion
situation deserves perhaps a different
mechanism, like dynamic, on-demand pty device
creation for root (which seems to me more
robust than a "reserved for root" mechanism,
which allows the possibility that root
processes have already used up that many
ptys when root needs one in an emergency).

Regards,

Clayton Weaver
<mailto: cgweav@email.com>

PS: Linux Golf Howto addenda

Long grass: when hitting out of long grass,
the grass tends to wrap around the heel of the club, where the club face meets the club shaft,
without offering comparable resistance to the
toe of the club face. This tends to close the
club face and deliver it to the ball at not
quite the intended angle. Solution: tilt the
toe of the club away from the ball a few
degrees before gripping the club. Soft,
well-watered green grass a few inches long
needs less opening of the club face than
foot long dry grass (more fiber in stems
than leaves) to accomplish the necessary
adjustment.

-- 
__________________________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

CareerBuilder.com has over 400,000 jobs. Be smarter about your job search
http://corp.mail.com/careers

