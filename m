Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269386AbTGJPwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 11:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269388AbTGJPwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 11:52:06 -0400
Received: from mail.ithnet.com ([217.64.64.8]:1028 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S269386AbTGJPwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 11:52:04 -0400
Date: Thu, 10 Jul 2003 18:06:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: green@namesys.com, mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre3 and reiserfs boot problem
Message-Id: <20030710180633.2c7085d9.skraw@ithnet.com>
In-Reply-To: <E19adfc-000Cax-00.ia6432-inbox-ru@f9.mail.ru>
References: <E19adfc-000Cax-00.ia6432-inbox-ru@f9.mail.ru>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jul 2003 19:49:20 +0400
"Peter Lojkin" <ia6432@inbox.ru> wrote:

> Hello,
> 
> I am not on the list so please CC me if replying...
> 
> I've found the problem, it's patch with description:
> 
> Fix potential IO hangs and increase interactiveness during heavy IO
> 
> http://linux.bkbits.net:8080/linux-2.4/user=mason/cset@1.1024?nav=!-|index.html|stats|!+|index.html|ChangeSet@-7d
> 
> After removing all changes from this cset, a had no problems
> mounting big reiserfs volumes...

Hello Marcelo,

can you please send me a separated patch for reversal to verify this.

Hello Chris,

if this is true I am willing to test other versions of the questionable patch
to solve the issue.

Thank you.
Stephan
