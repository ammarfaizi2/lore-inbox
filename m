Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261463AbTJFLKx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 07:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbTJFLKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 07:10:53 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:54413 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261463AbTJFLKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 07:10:52 -0400
X-Sender-Authentication: net64
Date: Mon, 6 Oct 2003 13:10:51 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel@vger.kernel.org
Subject: Alias names for network devices?
Message-Id: <20031006131051.107510d0.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

does anybody have an idea how to map a static device name to a network device
with dynamic appearance (e.g. ppp) ?

What I mean is something like:

static name : customer1
dynamic name: ppp25

The mapping should be made available at ip-up time, or better there should be
an _empty_ device which can be mapped on some existing dynamic device name and
should become empty again after its removal.

I know this sounds like a user-space question, but the kernel-question behind
is: is this concept possible at all? Can some userspace tool be written to
perform something like this?
The usage pattern is obviously doing SNMP statistics on users with varying
interface names.
Don't beat me for the subject line, I know alias ethernet devices are meant to
be something else, but how else would you call a second name for an existing
device?

Regards,
Stephan
