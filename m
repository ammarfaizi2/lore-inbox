Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752595AbWAHEDz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752595AbWAHEDz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jan 2006 23:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596AbWAHEDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jan 2006 23:03:55 -0500
Received: from zproxy.gmail.com ([64.233.162.199]:18309 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1752595AbWAHEDy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jan 2006 23:03:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=bqaba1Hay3HG/JcJkMqeCQOl65B60MaLyHrjuTeOT4bzlzFNXqdfoxXLhAk4QRu1lbzSZXZUGENUObA+F9UUfhXKbGcKXaVT+/+abdTar7lQUWNM4N0OhsS2ENZTOkXzO1e+kbEZuPlSl2w5kV7RBdHVpgh/spvY5NXuxOjDUyI=
Message-ID: <7282dfaf0601072003r61733f7erb55a27b8d302dc9b@mail.gmail.com>
Date: Sat, 7 Jan 2006 21:03:53 -0700
From: Jesus Arango <jesus.arango@gmail.com>
Reply-To: jarango@cs.arizona.edu
To: linux-kernel@vger.kernel.org
Subject: Qdisc API
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When implementing a queuing discipline, which functions in struct
Qdisc_ops must be implemeted ? By looking in net/sched I see that not
all queuing disciplines implement all functions. For example, the
default pfifo_fast_ops does not implement destroy, change, drop and
dump_stats. Could someone please elaborate on this topic: When and why
is each of these functions needed.

Thanks
Jesus
