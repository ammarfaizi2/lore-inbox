Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264469AbTH2HiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 03:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbTH2HiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 03:38:20 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:23778
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S264469AbTH2HiT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 03:38:19 -0400
Date: Fri, 29 Aug 2003 09:39:06 +0200
From: Voluspa <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O19int
Message-Id: <20030829093906.29af7599.lista1@comhem.se>
In-Reply-To: <200308291550.28159.kernel@kolivas.org>
References: <200308291550.28159.kernel@kolivas.org>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Aug 2003 15:50:22 +1000
Con Kolivas wrote:

> Patch against 2.6.0-test4-mm2

Patched the -mm2 kernel and perceive/see no regression during my usual
tests. In fact, I _believe_ the anti-starvation is even better now,
compared to O18.1

The new Blender 2.28a could be thrown into a self-starvation by altering
a few parameters in my test, resulting in the usual short freezes. And
2.28 behaved the same, although a bit harder to make it happen.

The altered test have no effect on either Blender with this O19int.

Mvh
Mats Johannesson
