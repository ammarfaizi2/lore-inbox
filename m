Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261672AbVDRFB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261672AbVDRFB4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261674AbVDRFB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:01:56 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:60809 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S261672AbVDRFBy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:01:54 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 17 Apr 2005 22:01:40 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Daniel Jacobowitz <dan@debian.org>
cc: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>, Chris Wedgwood <cw@f00f.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
In-Reply-To: <1113800136.355.1.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>
References: <4263275A.2020405@lab.ntt.co.jp>  <20050418040718.GA31163@taniwha.stupidest.org>
  <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org>
 <1113800136.355.1.camel@localhost.localdomain>
X-GPG-FINGRPRINT: CFAE 5BEE FD36 F65E E640  56FE 0974 BF23 270F 474E
X-GPG-PUBLIC_KEY: http://www.xmailserver.org/davidel.asc
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-18 at 00:42 -0400, Daniel Jacobowitz wrote:

> On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:
> > GDB based approach seems not fit to our requirements. GDB(ptrace) based 
> > functions are basically need to be done when target process is stopping.
> > In addition to that current PTRACE_PEEK/POKE* allows us to copy only a 
> > *word* size...
> 
> While true, this is easily fixable. 

Indeed, look at the systr_pmem_read() and systr_pmem_write() functions:

http://www.xmailserver.org/sysctr.html


- Davide

