Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263223AbVFXIdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263223AbVFXIdw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 04:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbVFXIdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 04:33:51 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:12199 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S263223AbVFXI0o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 04:26:44 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Jan Beulich" <JBeulich@novell.com>
cc: "jmerkey" <jmerkey@utah-nac.org>,
       "Christoph Lameter" <christoph@lameter.com>,
       "Clyde Griffin" <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Novell Linux Kernel Debugger (NLKD) 
In-reply-to: Your message of "Fri, 24 Jun 2005 09:38:41 +0200."
             <42BBD4A1020000780001D4D1@emea1-mh.id2.novell.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Jun 2005 18:26:21 +1000
Message-ID: <13706.1119601581@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jun 2005 09:38:41 +0200, 
"Jan Beulich" <JBeulich@novell.com> wrote:
>>1. No back trace
>
>You're the second one to mention this, and I wonder where you take this from.

Probably from this line in your patch.

debugger-2.6.5-7.183.patch:+//todo?   COMMAND(bt),

Which is misleading.  There is some backtrace code, under F12, where it
is called Stack Trace.

