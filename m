Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266573AbRGDXD7>; Wed, 4 Jul 2001 19:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266576AbRGDXDt>; Wed, 4 Jul 2001 19:03:49 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:18308
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S266573AbRGDXDg>; Wed, 4 Jul 2001 19:03:36 -0400
Date: Wed, 4 Jul 2001 16:07:50 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: <linux-kernel@vger.kernel.org>
Subject: framebuffer compile failure in 2.4.7-pre1
Message-ID: <Pine.LNX.4.33.0107041601120.31106-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Presumably from the ac merge, console_conditional_schedule made it's way
into pre1 fbcon.c, but neither the prototype from console.h nor the
function from printk.c came with it. (perhaps this requires merging the
console lock removal too?)


justin

