Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUE0FGp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUE0FGp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:06:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbUE0FGp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:06:45 -0400
Received: from ph130.in.ipex.cz ([213.168.168.130]:28456 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id S261396AbUE0FGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:06:36 -0400
Date: Thu, 27 May 2004 07:06:33 +0200
From: Jan Dvorak <jan.dvorak@kraxnet.cz>
To: linux-kernel@vger.kernel.org
Subject: Parallel port problem
Message-Id: <20040527070633.13e62219.jan.dvorak@kraxnet.cz>
Organization: KRAXNET.cz
X-Mailer: Sylpheed version 0.9.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got problem with parallel port - kernel seems to be constantly writing some data to it as soon as it gets loaded by lilo (and thus disturbing communication with any connected device). I have removed the parport and complete paralllel port support but with no effect. Under windows it works just fine (no data is sent until some device is really accessing the port). The data written seems to be connected to CPU usage. Kernel 2.4.21, 2.6.6, MB: K7S5A .. any ideas ?

Jan Dvorak

