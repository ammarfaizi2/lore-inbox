Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUIAKHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUIAKHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 06:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266003AbUIAKHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 06:07:10 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:45967 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S265795AbUIAKB0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 06:01:26 -0400
Message-ID: <5d0f6099040901030137a7f641@mail.gmail.com>
Date: Wed, 1 Sep 2004 12:01:25 +0200
From: Dirk Jagdmann <jagdmann@gmail.com>
Reply-To: Dirk Jagdmann <jagdmann@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: prevent hdd spin-down at system halt
In-Reply-To: <5d0f609904083107571d78a41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5d0f609904083107571d78a41@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello developers,

is it possible to disable the spin-down (or powerdown) of hard disks
when halting the system, via the kernel cmd-line or some
configurations in /proc?

If not, what would be the appropriate places in the sources where the
spin-down requests are sent to hard disks upon system halt?

I'm currently using x86 with IDE drives, but I think the (eventual)
solution should be platform independent.

--
---> Dirk Jagdmann
----> http://cubic.org/~doj
-----> http://llg.cubic.org
