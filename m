Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbVICFuK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbVICFuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 01:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161147AbVICFuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 01:50:10 -0400
Received: from codepoet.org ([166.70.99.138]:19415 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S1161145AbVICFuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 01:50:08 -0400
Date: Fri, 2 Sep 2005 23:50:07 -0600
From: Erik Andersen <andersen@codepoet.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Splitting out kernel<=>userspace ABI headers
Message-ID: <20050903055007.GA30966@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: andersen@codepoet.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com> <20050902134108.GA16374@codepoet.org> <22D79100-00B5-44F6-992C-FFFEACA49E66@mac.com> <20050902235833.GA28238@codepoet.org> <dfapgu$dln$1@terminus.zytor.com> <20050903042859.GA30101@codepoet.org> <4319330C.5030404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4319330C.5030404@zytor.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 02, 2005 at 10:22:20PM -0700, H. Peter Anvin wrote:
> Exportable types need to be double-underscore types, because the header 
> files in user space that would include them can generally not include 
> <stdint.h>.

I'm not talking about kernel headers that have to worry about
eventually being included in user space headers.  Those nearly
all live in include/asm.  I'm talking about the kernel headers
that define how userspace is supposed to interface with
particular kernel drivers or hardware.  Headers such as
linux/cdrom.h and linux/loop.h and linux/fb.h.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
