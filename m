Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262776AbTKUOVt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 09:21:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTKUOVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 09:21:49 -0500
Received: from main.gmane.org ([80.91.224.249]:22983 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262776AbTKUOVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 09:21:48 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Core file
Date: Fri, 21 Nov 2003 15:21:46 +0100
Message-ID: <yw1xd6blvm2t.fsf@kth.se>
References: <000001c3b037$9a92aee0$34dfa7c8@bsb.virtua.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:pwOpDpqClP82nTfdgTT24NWvQ5s=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Breno" <brenosp@brasilsec.com.br> writes:

> I´d like to know where i can find the source code that create filename.core
> when some memory fault happen.

In linux 2.6 it's in fs/exec.c.  Look for format_corename.

-- 
Måns Rullgård
mru@kth.se

