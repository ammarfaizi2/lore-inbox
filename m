Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262998AbTDIL0U (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 07:26:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbTDIL0T (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 07:26:19 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:21659
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262998AbTDIL0T (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 07:26:19 -0400
Subject: Re: bdflush flushing memory mapped pages.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Keith Ansell <keitha@edp.fastfreenet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <007601c2fecd$12209070$230110ac@kaws>
References: <007601c2fecd$12209070$230110ac@kaws>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049884771.9901.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 11:39:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 20:20, Keith Ansell wrote:
> help
> 
> My application uses SHARED memory mapping files for file I/O, and we have
> observed
> that Linux does not flush dirty pages to disk until munmap or msync are
> called.

This is correct behaviour


