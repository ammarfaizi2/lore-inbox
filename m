Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbTHTSeg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262104AbTHTSeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:34:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:54420 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbTHTSef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:34:35 -0400
Date: Wed, 20 Aug 2003 11:36:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Zwickel <martin.zwickel@technotrend.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-t3: vfs/ext3 do_lookup bug?!
Message-Id: <20030820113625.6a75d699.akpm@osdl.org>
In-Reply-To: <20030820171431.0211930e.martin.zwickel@technotrend.de>
References: <20030820171431.0211930e.martin.zwickel@technotrend.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Zwickel <martin.zwickel@technotrend.de> wrote:
>
> Today I wanted to check out some src-files from cvs.
>  But my fault was, that I ran cvs twice at the same time.
> 
>  so two "cvs upd -d -A" are now in 'D' state.
> 
>  I think they got stuck because both tried to access the same file.

How odd.  Were they the only processes which were in D state?
