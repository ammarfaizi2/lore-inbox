Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932335AbWAQKeH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932335AbWAQKeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 05:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWAQKeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 05:34:06 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:56517 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S932335AbWAQKeF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 05:34:05 -0500
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@ocs.com.au>
To: mita@miraclelinux.com (Akinobu Mita)
cc: ak@suse.de, linux-kernel@vger.kernel.org,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Christoph Hellwig <hch@infradead.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 3/4] compact print_symbol() output 
In-reply-to: Your message of "Tue, 17 Jan 2006 19:15:55 +0900."
             <20060117101555.GD19473@miraclelinux.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 17 Jan 2006 21:34:03 +1100
Message-ID: <10099.1137494043@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Akinobu Mita (on Tue, 17 Jan 2006 19:15:55 +0900) wrote:
>- remove symbolsize field
>- change offset format from hexadecimal to decimal

That is silly.  Almost every binutils tool prints offsets in hex,
including objdump and gdb.  Printing the trace offset in decimal just
makes more work for users to convert back to decimal to match up with
all the other tools.

