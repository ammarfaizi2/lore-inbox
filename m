Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbTJGLCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 07:02:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262139AbTJGLCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 07:02:19 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61962 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id S262133AbTJGLCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 07:02:19 -0400
Date: Tue, 7 Oct 2003 04:02:18 -0700 (PDT)
From: Tigran Aivazian <tigran@veritas.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: changes to microcode update driver.
In-Reply-To: <Pine.GSO.4.44.0310070352590.16056-100000@south.veritas.com>
Message-ID: <Pine.GSO.4.44.0310070401320.16056-100000@south.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Oct 2003, Tigran Aivazian wrote:
> 2. remove MICROCODE_IOCFREE ioctl for freeing the copy of held microcode
> (because there won't be such copy, see 1.)

Obviously this can't be done before the microcode_ctl userspace utility is
updated. So, for now we can just quietly suceed and only later remove the
actual ->ioctl() method.

Kind regards
Tigran

