Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267678AbUHFNwR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267678AbUHFNwR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 09:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267524AbUHFNwR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 09:52:17 -0400
Received: from mail.ocs.com.au ([202.147.117.210]:33476 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S265946AbUHFNwK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 09:52:10 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Pat Gefre <pfg@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Altix I/O code reorganization 
In-reply-to: Your message of "Fri, 06 Aug 2004 14:18:36 +0100."
             <20040806141836.A9854@infradead.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 06 Aug 2004 23:51:54 +1000
Message-ID: <8831.1091800314@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 14:18:36 +0100, 
Christoph Hellwig <hch@infradead.org> wrote:
>008-kdb-support-funtions:
>  kdb isn't in mainline, please add the two files to the kdb patch instead

No.  We have had this discussion before - kdb is an extensible
debugger.  Subsystems can add their own kdb commands to decode their
own data.  Those extensions to kdb belong in the subsystem code, not in
the main kdb patch.

