Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVIMGx6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVIMGx6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:53:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932414AbVIMGx6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:53:58 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:10451 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932363AbVIMGx5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:53:57 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@sgi.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Al Viro <viro@ZenIV.linux.org.uk>, Sam Ravnborg <sam@ravnborg.org>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, jdike@addtoit.com
Subject: Re: asm-offsets.h is generated in the source tree 
In-reply-to: Your message of "Tue, 13 Sep 2005 02:48:43 -0400."
             <1A89F249-1859-45CD-B9A2-F21EE98855FB@mac.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 13 Sep 2005 16:53:33 +1000
Message-ID: <24229.1126594413@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2005 02:48:43 -0400, 
Kyle Moffett <mrmacman_g4@mac.com> wrote:
>On Mon, Sep 12, 2005 at 09:15:25PM +0200, Sam Ravnborg wrote:
>> o Use some magic define trick like:
>>   - #include "ARCHDIR##foo.h"
>>   - I cannot recall correct syntax but something like this is doable
>
>The syntax for that is one of the following:
>
># define STR(x) #x
># define XSTR(x) STR(x)

Already exists, see include/linux/stringify.h

